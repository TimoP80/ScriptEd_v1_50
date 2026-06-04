# Changelog

All notable changes to ScriptEd are documented in this file. The format is roughly based on [Keep a Changelog](https://keepachangelog.com/).

For the most recent build-level changes only, see `BuildChangeLog.txt` next to this file. This file contains the **full** version history including older beta builds.

## [1.50-beta] - Build 9

### Added
- **"Create Nodes & Options" button** in the Dialogue Generator (Player Options tab).
  Generates 3 player options with implicit node links (`=> NODE:<name>`) and creates
  the corresponding dialogue nodes in the currently selected node, wiring up
  `linktonode` pointers automatically. Requires a node to be selected in the
  dialogue editor first.
- New `TDialogueGenerator.GeneratePlayerOptionsWithLinks` method that returns
  options tagged with target-node names.

### Changed
- Replaced the third-party `TAdvSmoothSplashScreen` (TMS Component Pack) with a
  native VCL splash screen (`SplashScreenForm.pas`). The splash image is loaded
  from `SplashIMG.png` in the EXE directory and shows a status label plus
  progress bar during startup.
- All `ConsoleDebug()` output now routes to the native splash screen's status
  label via the `ArcanumSCRLib.SplashStatusProc` callback, replacing the
  TMS-specific `SplashMessage()` implementation.
- Added JCL source paths to `ScriptEd.dproj` `DCC_UnitSearchPath` so the
  compiler can find `JclFileUtils` and friends without manual IDE configuration.
- **"Remove blank nodes" button** in the Dialogue Editor. Strips out any
  nodes that have no NPC text and no player options — these typically come
  from `dlg` files that contain padding lines like `{N}{}{}{}{}{}{}`
  between real dialogue nodes. (forum #41)

### Fixed
- **Quest Editor** now correctly displays quests that exist in the master
  quest list (`gamequest`) but are missing from the smart/dumb quest logs
  (`gamequestlog` / `GameQuestLogDumb`). Previously the listbox index was
  used as a direct array index into the quest logs, which would show wrong
  data for any quest whose ID didn't match its position in the log. All
  lookups now use `GetMesIndexByID(gamequest.entries[ItemIndex].index,
  logfile)` to translate the quest ID to the correct log array index.
  (forum #44)
- **Blank lines in `dlg` files** (lines like `{N}{}{}{}{}{}{}` with no NPC
  text) are no longer treated as dialogue nodes during loading. They were
  previously being promoted to float-message nodes, which corrupted the
  node list. (forum #41)
- **Verbose Debug toggle** in Preferences now actually takes effect. The
  checkbox was toggling a global in `ScriptEdConfig.pas` but the script
  compiler (`ArcanumSCRLib.pas`) reads a separate global of the same name
  (different casing). The two are now kept in sync whenever the config is
  loaded or saved. (forum #37)

## [1.50-stable] - Build 8

### Added
- **Dialogue Generator** accessible via `Script > "Dialogue Generator..."` menu
  item or the toolbar button. Tabbed interface with three modes:
  - *NPC Response* - generates an in-character NPC reply given a description /
    role and player dialogue.
  - *Player Options* - generates 3 concise player dialogue options from a
    context string.
  - *Journal Entry* - generates a journal entry with optional smart/detailed or
    simple/dumb tone.
  Copy-to-clipboard buttons for every result field. Requires Ollama to be
  enabled and configured in Preferences.
- **Ollama integration** (`OllamaLib.pas`):
  - Automatic detection of a running local Ollama server at
    `http://localhost:11434`.
  - OllamaCloud support with API-key authentication.
  - `TOllamaAPIBase` / `TOllamaLocalAPI` / `TOllamaCloudAPI` class hierarchy.
  - `GenerateText`, `ListModels`, `IsServerRunning`, `GenerateTextAsync`.

  Models are pulled via the standard `ollama pull <modelname>` command-line
  workflow. All models visible to the local Ollama server are auto-detected.

### Fixed
- Script parser: the special case `transform Attachee into basic prototype (num)`
  was broken and is now fixed.
- Script parser: `have (obj) try to steal 100 coins from (obj)` was failing to
  compile; this is now fixed.
- Flags are now set properly in the GUI version of the compiler.
- Command-line script compiler now correctly stores flags when specified.
- Command-line script compiler passes the compilation of **all** official
  scripts.
- Command-line script compiler was updated to use the new `ArcanumSCRLib` code.

### Changed
- Rewrote and optimized parts of the script compiler with the help of AI
  assistance, removing ~50% of the code in some areas.
- Added hints to various sections of the dialogue editor.
- Updated the application icon to a new one generated with DALL-E 3.
- Dialogue Editor window: the NPC text and player options are now visible at
  all times in the tree view. The tree view is now HTML-formatted and
  re-renders the display whenever you edit the NPC text or player options.
  *These items are for display only - they cannot be edited from the tree
  nodes directly.*

> **Note on AI performance:** the speed of the AI text generation depends on
> your hardware (CPU, GPU, memory) and the parameter count of the model. On a
> Ryzen 5600X + GTX 1070 + 16 GB DDR4 setup, `mistral:7b` takes 30 s to a
> minute per response. The sub-7B parameter models are much faster and more
> suitable for rapid dialogue iteration.

## [1.50-beta] - Build 7

### Added
- Button to add float lines from a listbox. Each line represents one float
  message - useful for bulk-importing AI-generated (e.g. ChatGPT) message
  lists.
- Button to clear the entire dialogue (with a confirmation dialog) - useful
  when reworking a dialogue from scratch.
- Button to link to another dialogue, using a global variable for both the
  dialogue entry point and the script line to call. This is very useful for
  inter-NPC dialogues that require complex scripting to implement. The
  calling and receiving scripts both need to be set up with the pattern:
  ```
  dialog Global Variable <x>  // entry point
  loop for Everyone in Group (PC and NPC, single player)
      IF Current Looped Object is named <internal_name>
          THEN call script attached to Current Looped Object at point 9
               at line Global Variable <y> with triggerer Player
  loop end
  ```
- Player option editor option to directly create a new node for the
  dialogue.

## [1.50-beta] - Build 6

### Added
- Script compiler now supports comments that have no space between `//` and
  the comment text - they are automatically formatted as `// <comment>`.
- Option to automatically insert a new voice-over (VO) number for each new
  node, great for voiced dialogues. Does not increment the VO number for
  nodes that have no voice-over.
- Search options in both script loader windows (load official script and
  module script loader). Main campaign voiced dialogues can now also be
  filtered.
- Voice-over column in the module script loader for filtering dialogues that
  have voice-over.
- MES file header editor.
- Condition and action command wizards (like the original ScriptEd) and a
  full `IF..THEN..ELSE` statement wizard.
- Build number is now displayed in the main form caption.

### Fixed
- Dialogue not being reset after loading a script with no dialogue when a
  dialogue file was previously loaded.
- Script name not being updated properly (it was updating without the
  script id).
- Added code to add line 1 to a newly created dialogue if there are no
  dialog entry points in the script (previously caused a `.dlg` parse
  error).

### Changed
- Editor code completion: certain opcodes now invoke a specific selector
  window, e.g. `set global flag (num) to true` invokes the global flag
  selector.

## [1.50-beta] - Build 5

### Fixed
- Critical bug in the script parser that caused `transform Attachee into
  basic prototype (num)` to fail to compile.
- Access violation on exit in `PLG_CheckRefs.dll`, traced to JCL Unit
  Versioning (disabled).
- Various other plugin stability fixes.

### Added
- Plugins now use the same VCL skin as the main program.
- Option to use Troika's original `DbMaker.exe` for building module databases
  instead of the internal routines.
- Command-line tool: `ScriptCompiler.exe` for mass decompiling scripts to
  text and back to `.scr`. Can decompile all main-game scripts.
- Button for automatic voice-over numbering in the dialogue editor.
- ArcanumSCRLib installation folder is now read from the registry correctly.
- Speech playback implemented for dialogues with voice-over.

### Known issues
- Dialogue is not reset when loading another script that has no dialogue
  attached.

## [1.50-beta] - Build 4

### Added
- Script creation and modification date columns in the module script loader.
- Fancy splash screen on startup.
- Plugin for creating speech files using the Windows SAPI5 Text-to-Speech
  engine.
- VCL skin applied to the editor.

### Fixed
- MES editor entry deletion: deleting the last entry would cause an access
  violation (only related to updating the listview).
- Script parser bugs (thanks to Anthony Bailey for the fixes). For example
  this line did not compile before:
  `stat 4 of Triggerer: adjust by PC Variable 1001 of Triggerer`

### Changed
- Ported code to work with **Delphi 10 Seattle**.

## [1.50-beta] - Build 3

### Added
- Right-click menu in the module script loader for various operations
  (currently only delete).
- More right-click info tip data types: script number, basic prototype,
  stat.
- DAT creation functions tweaked to work properly. The filenames in the
  directory tree were stored incorrectly, without a null character at the
  end.
- Buttons for decompressing and compressing module data. Compress supports
  two modes: standard (single `.dat`) and advanced (split into `.patch<n>`
  files and a main `.dat`).
- Automatic helper script importing via an `ImportScript` procedure present
  in a script. This is used for providing additional helper scripts with an
  installer script that contains a series of `AddHelperScript` commands.
- Helper script manager in the preferences screen.
- Setting to toggle the new behaviour of recompiling the script on save.
- Folder monitoring for the module list - the list auto-refreshes when
  files/folders are added or removed.
- Setting to toggle the confirmation dialog for deleting a player option.

### Fixed
- Player option editor: data from a previously edited player option was
  not cleared properly.
- Incorrect code when loading compressed modules.
- Player option editor focus: `UpdatePlayerOptions` was called after
  selecting the line, causing the list to lose focus when moving a player
  option up/down.
- DAT file handling now reports the filename it tried to open if an error
  occurs.
- Parsing of lighting-scheme message files (1AM, etc. without comment
  prefix). The parser now ignores any input outside curly braces that is
  not prepended with `//`.
- Crash when pressing OK in the module selector without anything selected.

## [1.50-beta] - Build 2

### Fixed
- Arcanum installation path management: you can now specify a folder of
  your own choice if you have multiple copies of Arcanum installed.
- Undo is now working (without buffer, so only the text that was in the
  editor before compiling is restored).
- MES entry data is properly cleared from the last usage of the generic
  MES editor.
- Issues with some plugin-related functions. `ModulePath` should now be
  returned correctly.
- Female NPC text is now correctly updated when you toggle the "use text
  from male NPC line" checkbox.
- Issues with the existence check of the dialogue file when creating a new
  dialogue (added a safety check that lets the user cancel).
- Script parser finetuned to allow consecutive lines without linebreaks
  in between.

### Added
- MRU menu for module scripts. The full path is stored so in case you
  change the module in between loading scripts they can be accessed again
  easily. *NOTE: the module folder variable still holds only the currently
  selected module, so strangeness may occur; use the scripts in the
  currently selected module and select another module to edit data in that
  module.*
- Listview column widths are also saved from the module script loader
  window.
- More configuration options. Compiling the script on pressing Enter can
  now be disabled.
- Default line number step when adding new nodes.
- Basic colour coding for nodes: float messages and empty lines are
  coloured differently in the node list.
- Multiple player options can be copied and pasted.
- Optional gender-specific strings (used for automatically synchronising
  NPC text for the female player with words like "sir" -> "madam").
- Helper-script commands:
  - `SelectGlobalFlag: Integer`
  - `SelectGlobalVar: Integer`
  - `SelectPCFlag: Integer`
  - `SelectPCVar: Integer`
  - `SelectQuest: Integer`
  - `SelectRumor: Integer`
  - `SelectInternalName: Integer`
  - `ChooseScript: Integer` (returns the script ID)
  - `ChooseFocus: String`
  - `ChooseValue: String`
- Global flag / variable / quest / internal name information display when
  right-clicking on certain script lines or `Global Flag`/`Global Variable`
  keywords. Can also display dialogue lines or float messages if they are
  being called as regular numbers.

## [1.50-beta] - Initial release

First public release of the from-scratch rewrite.
