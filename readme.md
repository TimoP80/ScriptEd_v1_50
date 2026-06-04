# ScriptEd v1.50

A complete script and dialogue editor for **Arcanum: Of Steamworks and Magick Obscura** (2001, Troika Games). ScriptEd lets modders edit, compile, and manage the game's proprietary `.scr` (script) and `.dlg` (dialogue) files using a friendly text-based workflow, and it ships with a modern AI-assisted dialogue generator powered by [Ollama](https://ollama.com/).

The original ScriptEd was written in 2001 and the source code was lost. This is a from-scratch rewrite in Delphi (currently targeting Delphi 10 Seattle and later) that is **larger, better, faster, and has more features** than the original.

> **Note:** You need to run ScriptEd as administrator if installing to `C:\Program Files (x86)`. Windows is very restrictive with file permissions otherwise.

---

## What is Arcanum modding?

Arcanum stores its game logic in a small set of proprietary binary file formats living inside `*.dat` archives in the game directory:

- `.scr` - compiled scripts (NPC AI, triggers, item behaviour, quest logic)
- `.dlg` - dialogue trees (NPC replies, player choices, jump-to-node pointers)
- `.mes` - message-string tables (all in-game text, indexed by integer ID)
- `.proto` - prototype records (items, NPCs, placeables)
- `.dlg` headers, voice-over numbers, attachment points, etc.

Modders traditionally had no way to edit any of this without a hex editor. ScriptEd gives them a text editor for `.scr`/`.dlg` files, structured editors for `.mes` tables, and a complete pipeline for round-tripping between the human-readable text format and the binary in-game format.

---

## How the program works

### High-level architecture

ScriptEd is a single Delphi `Vcl.Forms` application (`ScriptEd.dpr`) with the following layers:

```
+-----------------------------------------------------------------+
|  ScriptEdWindow (TMainForm)                                     |
|  - Main menu, toolbar, SynEdit source view, compiler log        |
+-----------------------------------------------------------------+
                              |
                              v
+-----------------------------------------------------------------+
|  ArcanumSCRLib  (the heart of the program)                      |
|  - Text <-> binary .scr compiler/decompiler                     |
|  - MES parser                                                   |
|  - Opcode table, parameter type resolution                      |
|  - Pluggable ConsoleDebug / SplashStatusProc callbacks          |
+-----------------------------------------------------------------+
        |                    |                       |
        v                    v                       v
+--------------+   +------------------+   +------------------+
| DLGFileIO    |   | MESFileIO /      |   | arcdatlib        |
| DLGParser    |   | mesparser        |   | (DAT I/O, open,  |
| DialogueEdr  |   | QuestEditor      |   |  extract, mount) |
+--------------+   +------------------+   +------------------+
        |
        v
+-----------------------------------------------------------------+
|  OllamaLib / DialogueGenerator / DialogueGeneratorForm         |
|  - HTTP client for local Ollama server or OllamaCloud          |
|  - Prompt templates for NPC replies, player options, journal    |
+-----------------------------------------------------------------+
```

### Startup sequence

`ScriptEd.dpr` creates the splash screen (`SplashScreenForm`) first, then `TMainForm` and 30+ child forms in order, updating the splash progress bar at each step. Once the main form is shown, the splash fades away and `MainForm.FormCreate` takes over:

1. Load configuration (`ScriptEdConfig`).
2. Initialize the syntax highlighter and code completion (`SynCompletionProposal` is seeded with focus strings, action opcodes, and condition opcodes).
3. Parse the static MES files in the `data\` folder (`AttachmentPoint.mes`, `Stats.mes`, `ScriptCallType.mes`, etc.).
4. Initialize the opcode tables (`InitOpcodes` in `ArcanumSCRLib`).
5. If Ollama is enabled in Preferences, instantiate the `TOllamaAPIBase` (either `TOllamaLocalAPI` for `http://localhost:11434` or `TOllamaCloudAPI` for the cloud endpoint) and check `IsServerRunning`.
6. Scan the `plugins\` directory for `PLG_*.dll`, `DEV_*.dll`, and `DLG_*.dll` plugins.
7. If Arcanum is installed, read the `Arcanum3.dat` and `Arcanum4.dat` indexes, parse the global quest XP rewards, prototype descriptions, etc., and reload the last-used module.
8. Load the helper scripts (`HelperScripts.dws`) which expose a DelphiWebScript II scripting layer to the user.
9. Initialize the BASS audio DLL for voice-over preview playback.

### The script editor (left pane of MainForm)

The main editor is a `TSynEdit` showing the currently loaded `.scr` (and optionally the linked `.dlg`) in a *human-readable text format*. Lines are numbered and prefixed, with comments interleaved.

Example text view of a script:
```
description "a goblin patrol guard"

MAX_LINES_ALLOCATED 10

0. give gold to Triggerer
1. if Attachee is not hostile to Triggerer
   0.1. say "[grunt] Who goes there?"
   0.2. start dialogue node 1
1.3. else
   1.3.1. say "Die, scoundrel!"
   1.3.2. attack Triggerer
```

The text format is **fully round-trippable**: every line can be parsed back to the exact same binary `.scr`. This is what makes ScriptEd a viable modding tool - users edit text, hit **Compile**, and get a binary file that the game can load.

### Script compilation pipeline

When the user clicks **Compile** (`MainForm.Compile1Click`):

1. **Save & dump the text buffer** to `temp.txt`.
2. `ArcanumSCRLib.ParseTextScript` reads the text, walks it line-by-line, and emits the in-memory `currentscript: ScriptFile` record.
3. `ArcanumSCRLib.SaveScript` writes that record to `temp.scr` (the binary format).
4. If `AutoRemapLineNumbers` is on, the compiler then re-maps any `goto line X` opcodes in the original script that may have been displaced by line additions/deletions.
5. The text editor is refreshed to reflect any renumbering.

The opcodes are defined as named constants in `ArcanumSCRLib.pas` (e.g. `SA_GOTO`, `SA_SAY`, `SC_HOSTILE_TO`). `ParseScriptLine` knows the parameter types of each opcode and resolves them at compile time:

- `PARAM_TYPE_OBJ` -> opens `SelectFocus` (focus string selector)
- `PARAM_TYPE_NUM` -> opens the appropriate selector window (global flag, global var, quest, rumor, value, etc.)

This is what makes typing an action like `set global flag (num) to true` in the editor automatically invoke a pop-up that lets you click on the right global flag rather than typing its raw index.

### The dialogue editor (DialogueEditor form / Form3)

Dialogues are stored in `.dlg` files. The dialogue editor shows the dialogue as a tree of nodes. Each node has:

- An NPC line (male + optional female text)
- A list of player options
- For each player option, a `linktonode` pointer

The dialogue tree is the actual conversation flow. When the player says an option, the engine jumps to the linked node, displays its NPC text, and shows the next set of options. Terminal nodes have no options, and "leaf" options can `goto line X` of a `.scr` script to actually do something (give gold, start combat, etc.).

The dialogue editor lets you:
- Add/remove/reorder nodes
- Edit NPC text and player options
- Automatically number voice-overs for use with the SAPI5 plugin
- Link to another dialogue (for inter-NPC conversations that require global-variable indirection)
- Clear the entire dialogue (with a confirmation prompt)

The node view is an HTML-formatted tree component that also shows the *current* NPC text and player options as you edit them (display only - the editing still happens in the regular editors).

### Helper scripts (DelphiWebScript II)

`HelperScripts.dws` is a script the user can extend. It runs through the embedded **DelphiWebScript II** (dwsCompiler) engine. Helper scripts can call into the host application through a curated API (`dws2Unit1Functions...`):

- `SelectGlobalFlag()`, `SelectGlobalVar()`, `SelectPCFlag()`, `SelectPCVar()`, `SelectQuest()`, `SelectRumor()`, `SelectInternalName()`, `ChooseScript()`, `ChooseFocus()`, `ChooseValue()` - all open selector windows and return the chosen ID
- `AddScriptCommand(...)` - inserts a script line into the editor at the current cursor
- `InsertScriptLine(...)` - inserts an arbitrary line of text
- `EditorAddLine(...)` - adds a new line at the end
- `CompileScript()` - triggers a compile
- `DebugMessage(...)` - writes to the compiler log
- `ShowScriptInfo(...)` - pops up a script info window
- `AddHelperScript(...)` - registers a new helper script from a string
- `InitializeHelperScriptMenu(...)` - lets the helper script populate the **Helper Scripts** submenu dynamically

Helper scripts are how custom installers / "wizards" are written for ScriptEd.

### Plugins

ScriptEd has a plugin system (`pluginapi.pas`). At startup, it scans three directories:

- `plugins\PLG_*.dll` - standard user-facing plugins (loaded into the Plugins menu)
- `plugins\DEV_*.dll` - developer tools
- `plugins\DLG_*.dll` - dialogue editor plugins

The shipped `plugins\DialogueTester` is a simple example: it opens a window where you can pick a `.scr` + `.dlg` pair and step through the dialogue to preview it.

Plugins can mark themselves as a `isspeechgenerator=True` to be auto-loaded as the active SAPI5 voice provider for the dialogue editor's "Generate Speech" button.

### DAT file I/O

`arcdatlib.pas` implements the **DAT file format** that Arcanum uses to pack its game data. A DAT is a flat directory followed by zlib-compressed file blobs with a 32-bit hash table index. ScriptEd can:

- Open an Arcanum `.dat` (Arcanum3.dat, Arcanum4.dat) and list its contents
- Open a module `.dat` (in `Arcanum\Modules\<module>\`)
- Open/extract individual `.scr`, `.dlg`, `.mes` files from a DAT
- Patch a file by name (if the DAT allows it, e.g. for the Arcanum4 patching scheme)
- **Build** a DAT from a folder of files, either as a single `.dat` or split into `.patch0`, `.patch1`, ... files for Steam Workshop / GOG patching
- Compress and decompress module data with the same algorithm Troika originally used

There is also a "use the original `DbMaker.exe`" option in Preferences for users who want bit-exact output that matches what Troika's tool produced.

### MES file I/O

`MESFileIO.pas` and `mesparser.pas` handle Arcanum message files. A `.mes` file is essentially a list of `{ index, text }` pairs:

```
{100}{Hello, traveler.}
{101}{I will not suffer a thief here.}
{102}{%name! What brings thee to these parts?}
```

ScriptEd ships dedicated editors for several MES files:
- `QuestEditor` (`Quests.mes`, `QuestEntries.mes`)
- `JournalEditor` (`Journal.mes`)
- `MESFileShow` (generic MES viewer for any other file)
- `MESFileHeader` editor (for MES files with a custom header block)

The parser preserves comments and blank lines so round-tripping is lossless.

### AI integration - the Dialogue Generator

Since Build 8, ScriptEd integrates with [Ollama](https://ollama.com/) to provide AI-assisted dialogue creation. The implementation is in three files:

- **`OllamaLib.pas`** - a thin HTTP client around the Ollama REST API. Two implementations of `TOllamaAPIBase`:
  - `TOllamaLocalAPI` for `http://localhost:11434` (the default local Ollama server)
  - `TOllamaCloudAPI` for the cloud endpoint, with Bearer-token auth
  Both expose `GenerateText`, `ListModels`, `IsServerRunning`, and `GenerateTextAsync`.

- **`DialogueGenerator.pas`** - prompt templates and generation functions:
  - `GenerateNPCResponse(NodeDescription, PlayerText)` - in-character NPC reply
  - `GeneratePlayerOptions(Context)` - three concise player options
  - `GeneratePlayerOptionsWithLinks(Context)` - same, but each option has a `=> NODE:<name>` suffix indicating where it should lead
  - `GenerateJournalEntry(Topic, Smart)` - smart/detailed or simple/dumb journal entry
  - `GenerateSmartVersion(Text)` / `GenerateDumbVersion(Text)` - rewrite text at a higher/lower register

- **`DialogueGeneratorForm.pas`** - the actual UI: a tabbed form with NPC Response, Player Options, and Journal Entry tabs. Each tab has a "Generate" button and a "Copy to Clipboard" button. The Player Options tab also has a **"Create Nodes & Options"** button that takes a node-link-suffixed response and materialises it as real dialogue nodes in the current dialogue, wiring up `linktonode` pointers automatically.

The user configures Ollama in Preferences (URL / API key, model name, enable flag). The main form holds a single `ollamarequest: TOllamaAPIBase` and a single `ollamamodel: string`, which the generator form receives via the `TFormDialogueGen.Execute(API, Model)` class method.

**Hardware note:** text-generation speed depends entirely on the model and the user's hardware. On a Ryzen 5600X + GTX 1070 + 16 GB DDR4, generating with `mistral:7b` takes 30 s to a minute. The sub-7B models are dramatically faster and are recommended for rapid dialogue iteration.

### Voice-over / SAPI5 speech generation

The dialogue editor has a "Generate Speech" button that uses the Microsoft SAPI5 Text-To-Speech engine to render an NPC line to a `.wav` file. The auto-voiceover-numbering feature adds a unique VO number to each new node automatically (only for nodes that have voice-over).

A speech DLL plugin is shipped under `plugins\DialogueTester\` as a reference implementation of the speech-generator plugin API.

### MRU / form placement / settings

ScriptEd uses the JEDI VCL (`JvFormPlacement`, `JvAppIniFileStorage`, `JvMRUManager`) to remember:
- Window position, size, and state across runs
- Most-recently-used script files (`JvMRUManager1`)
- All preference toggles (in `ScriptEd.ini` via `JvAppIniFileStorage`)

### Build pipeline

The solution is built with Embarcadero Delphi (`.dproj`). The relevant project files:

- `ScriptEd.dproj` - main GUI application
- `ScriptEd.dpr` - program entry point
- `ScriptCompiler.dproj` - command-line tool for batch decompile/compile of all main-game scripts
- `ScriptDumper.dproj` - dumps the full scripting API to a text file for documentation
- `ResultCodeParser.dproj` - extracts action/condition opcode return-type metadata from the Arcanum binaries

The compiler is invoked with a JCL path in `DCC_UnitSearchPath` (`C:\DelphiComp\jvcl-latest\jcl\jcl\source\common` etc.).

---

## Project layout

```
ScriptEd_v1_50/
  readme.md             <- this file
  changelog.md          <- version history
  BuildChangeLog.txt    <- per-build changelog (kept in parallel)
  GPL.txt               <- GNU GPL v2
  todo_list.txt
  bugreports_and_suggestions.txt
  HelperScripts.txt
  ScriptEd.ini          <- user settings
  helperscripts/        <- user-saved helper scripts
  src/                  <- Delphi source code
    ScriptEd.dpr        <- main program
    ScriptEdWindow.pas  <- TMainForm
    ArcanumSCRLib.pas   <- core text<->binary compiler
    arcdatlib.pas       <- DAT archive I/O
    DialogueEditor.pas  <- Form3 (dialogue tree)
    DialogueGenerator*.pas
    OllamaLib.pas
    *.pas, *.dfm        <- one pair per form / module
  plugins/
    DialogueTester/     <- sample plugin
    ...                 <- other PLG_*, DEV_*, DLG_* DLLs
  TestCases/            <- regression test scripts
  orig/                 <- original Delphi 7 sources (reference)
  Delphi7Source/        <- backup of the Delphi 7 import
```

---

## Compilation requirements

- **Embarcadero Delphi 10 Seattle or later** (the project was ported from Delphi 7)
- **JEDI Code Library (JCL)** - source path must be in `DCC_UnitSearchPath` (e.g. `C:\DelphiComp\jvcl-latest\jcl\jcl\source\common`)
- **JEDI Visual Component Library (JVCL)** - same, for the Jv* runtime packages
- **TMS VCL Styles** - the app uses the `Slate Classico` style (set in `ScriptEd.dpr`)
- **DelphiWebScript II** (bundled in `src\dws*`)
- **SynEdit / SynHighlighterGeneral** (bundled)
- **JCL JSON / Net HTTP Client** (in the box since Delphi XE)

---

## License

ScriptEd is licensed under the **GNU General Public License v2**. See `GPL.txt`.
