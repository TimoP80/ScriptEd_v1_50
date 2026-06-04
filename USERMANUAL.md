# ScriptEd v1.50 User Manual

A comprehensive guide to using ScriptEd for Arcanum modding.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Installation & Setup](#installation--setup)
3. [Quick Start](#quick-start)
4. [Main Interface](#main-interface)
5. [Script Editor](#script-editor)
6. [Dialogue Editor](#dialogue-editor)
7. [MES Editors](#mes-editors)
8. [AI Dialogue Generator](#ai-dialogue-generator)
9. [Plugin System](#plugin-system)
10. [Compilation Workflow](#compilation-workflow)
11. [Preferences & Configuration](#preferences--configuration)
12. [Troubleshooting](#troubleshooting)
13. [Reference](#reference)

---

## Introduction

ScriptEd is a complete script and dialogue editor for **Arcanum: Of Steamworks and Magick Obscura** (2001, Troika Games). It lets modders edit, compile, and manage the game's proprietary `.scr` (script) and `.dlg` (dialogue) files using a friendly text-based workflow.

> **Note:** You need to run ScriptEd as administrator if installing to `C:\Program Files (x86)`. Windows is very restrictive with file permissions otherwise.

### What is Arcanum modding?

Arcanum stores its game logic in proprietary binary formats inside `*.dat` archives:

- `.scr` - compiled scripts (NPC AI, triggers, item behaviour, quest logic)
- `.dlg` - dialogue trees (NPC replies, player choices, jump-to-node pointers)
- `.mes` - message-string tables (all in-game text, indexed by integer ID)
- `.proto` - prototype records (items, NPCs, placeables)
- `.dlg` headers, voice-over numbers, attachment points, etc.

ScriptEd gives modders a text editor for `.scr`/`.dlg` files, structured editors for `.mes` tables, and a complete pipeline for round-tripping between human-readable text and the binary in-game format.

---

## Installation & Setup

### System Requirements

- **Windows 7 or later** (Windows 10/11 recommended)
- **Embarcadero Delphi 10 Seattle or later** (for building from source)
- **JCL (Jedi Code Library) 2.8+** - for file utilities and string handling
- **JVCL (Jedi Visual Component Library) 3.0+** - for UI components
- **Ollama** (optional) - for AI-assisted dialogue generation
  - Local: `http://localhost:11434`
  - Or OllamaCloud with API key

### Installation Steps

1. Extract the ScriptEd archive to a permanent location (e.g., `C:\Tools\ScriptEd\`)
2. If installing to `C:\Program Files`, run the installer as Administrator
3. Copy the `plugins\` folder to the same directory as `ScriptEd.exe`
4. Create a `data\` folder next to the executable if you want to use custom MES files
5. Double-click `ScriptEd.exe` to launch

### First Run

On first launch, ScriptEd will:

1. Create `ScriptEd.ini` in the application directory
2. Load default settings
3. Scan the `plugins\` directory for available plugins
4. Attempt to detect an installed Arcanum game from the Windows registry

If Arcanum is not detected, you can manually set the path in **File > Set Module Folder** or via Preferences.

### Ollama Setup (Optional)

To use the AI Dialogue Generator:

1. Install Ollama from [ollama.com](https://ollama.com)
2. Run `ollama pull mistral:7b` (or another model)
3. In ScriptEd, go to **Edit > Preferences**
4. Enable "Ollama integration"
5. Set provider to "Local" (default: `http://localhost:11434`)
6. Enter the model name (e.g., `mistral:7b`)
7. Click "Test Connection" to verify

For OllamaCloud:
1. Select "OllamaCloud" as provider
2. Enter your API endpoint and key
3. Click "Test Connection"

---

## Quick Start

### Opening a Script

1. Launch ScriptEd
2. Click **File > Open Script** (or press `Ctrl+O`)
3. Navigate to your module's `scr\` folder
4. Select a `.scr` file
5. The script loads into the editor as formatted text

### Editing and Compiling

1. Edit the script text in the main editor pane
2. Press **Compile** (`F9`) or click **Script > Compile**
3. Check the compiler log at the bottom for errors
4. If successful, the binary `.scr` file is updated

### Creating a New Script

1. Click **File > New Script** (or press `Ctrl+N`)
2. A blank script with a default header is created
3. Edit the description line: `description "My quest script"`
4. Add script lines using the **Script > Action** and **Script > Condition** menus
5. Save with **File > Save Script**

### Working with Dialogue

1. Open a script that has an associated `.dlg` file
2. Click **Script > Dialogue Editor** (or press `Ctrl+D`)
3. The dialogue tree appears in the left pane
4. Click nodes to view/edit NPC text and player options
5. Use the **AI** tab to generate dialogue with Ollama

---

## Main Interface

### Window Layout

```
+-------------------------------------------------------------------+
| Menu Bar: File Edit Script Module Plugins ...                     |
+----------+-------------------------------------------+------------+
| Toolbar  |  Script Editor (TSynEdit)                 | Compiler   |
| [New]    |                                           | Log        |
| [Open]   |  0. IF global flag 1001 is set            |            |
| [Save]   |     THEN goto line 5                      | Status:    |
| [Compile]|  1. dialog 500                            | OK         |
|          |  2. return and SKIP default               |            |
|          |                                           |            |
+----------+-------------------------------------------+------------+
| Status Bar                                                         |
+-------------------------------------------------------------------+
```

### Menu Structure

**File**
- New Script (`Ctrl+N`)
- Open Script (`Ctrl+O`)
- Save Script (`Ctrl+S`)
- Save Script As...
- Exit

**Script**
- Action... (insert script action)
- Condition... (insert condition)
- Compile (`F9`)
- Undo Compile
- Dialogue Editor (`Ctrl+D`)
- Set Script ID...

**Module**
- Select Module...
- Edit Global Flags
- Edit Global Variables
- Edit PC Flags
- Edit PC Variables
- Edit Internal Names
- Edit Factions
- Quests...

**Plugins**
- [Dynamic list of loaded plugins]

**Help**
- About ScriptEd

### Toolbar Buttons

| Button | Function |
|--------|----------|
| ![New](https://via.placeholder.com/16/2563eb/ffffff?text=N) | New script |
| ![Open](https://via.placeholder.com/16/2563eb/ffffff?text=O) | Open existing script |
| ![Save](https://via.placeholder.com/16/2563eb/ffffff?text=S) | Save current script |
| ![Compile](https://via.placeholder.com/16/2563eb/ffffff?text=C) | Compile script to binary |

### Status Bar

The status bar shows:
- **Current script filename**
- **Line/column position** of the cursor
- **Compile status** (Ready, Compiling..., OK, ERROR)
- **Plugin count** and opcode counts in About box

---

## Script Editor

### Text Format

ScriptEd displays scripts in a human-readable text format. Each line is numbered and prefixed:

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

### Round-Tripping

The text format is **fully round-trippable**: every line can be parsed back to the exact same binary `.scr`. This is the core of ScriptEd's value proposition - users edit text, hit Compile, and get a binary file the game can load.

### Syntax Highlighting

- **Keywords**: `IF`, `THEN`, `ELSE`, `GOTO`, `RETURN`, `DIALOG`, etc.
- **Opcodes**: `give gold`, `say`, `attack`, `set global flag`, etc.
- **Numbers**: Line references, quantities, IDs
- **Comments**: Lines starting with `//`

### Code Completion

As you type, ScriptEd suggests completions based on:

1. **Focus strings** (NPC names, item names, etc.)
2. **Action opcodes** (from `ActionOpcodes` table)
3. **Condition opcodes** (from `ConditionOpcodes` table)

Type an opcode name and press `Ctrl+Space` to invoke completion manually.

### Editor Commands

| Key | Action |
|-----|--------|
| `Ctrl+N` | New script |
| `Ctrl+O` | Open script |
| `Ctrl+S` | Save script |
| `F9` | Compile |
| `Ctrl+Z` | Undo (text buffer) |
| `Ctrl+Space` | Code completion |
| `Ctrl+Click` | Jump to referenced line (GOTO targets) |

### Working with Script Lines

#### Adding Actions

Use **Script > Action** to insert a new action line. A wizard guides you through:

1. Select the action type (e.g., `give gold`, `say`, `dialog`)
2. Enter parameters (e.g., quantity, message ID)
3. The action is inserted at the current cursor position

#### Adding Conditions

Use **Script > Condition** to insert a condition. The wizard helps you build `IF..THEN..ELSE` structures:

1. Select condition type
2. Set parameters
3. Choose THEN action
4. Optionally add ELSE action

#### Using the Action/Code Editor

For complex `{Test}` and `{Result}` fields (in dialogue conditions/actions), click the **Edit** button to open the Dialogue Code Editor. This provides:

- A searchable reference of all 2-letter Arcanum dialogue codes
- Insert or Replace mode
- Inline help for syntax

---

## Dialogue Editor

### Opening the Dialogue Editor

- Select a script with an associated `.dlg` file
- Click **Script > Dialogue Editor** (`Ctrl+D`)
- The dialogue tree loads automatically

### Dialogue Tree (Left Pane)

The tree displays all dialogue nodes:

```
┣ [Node: 1] - line 10, 3 options
┃ ┣ NPC Text: "Hello, traveler. What brings you here?"
┃ ┣ Player option: "I'm looking for work." => 2
┃ ┣ Player option: "None of your business." => 3
┃ ┗ Player option: "Goodbye." => -1 (exit)
┣ [Node: 2] - line 20, 2 options
┃ ...
```

- **Blue text**: Node name
- **Green text**: Line number and option count
- **Black text**: NPC dialogue
- **Player options**: Show text and target node link

### Editing Node Data (Right Pane)

Select a node to edit its properties:

#### NPC Text

- **Text field**: The NPC's dialogue line
- **Gender test**: Male/Female/Both - determines which text is used
- **VO number**: Voice-over file number (if applicable)

#### Player Options

Each option has:
- **Text**: What the player sees/selects
- **Conditions** (`{Test}`): Requirements to show this option
- **Actions** (`{Result}`): Side effects when selected
- **IQ test**: Minimum intelligence required
- **Link to node**: Which dialogue node to jump to
- **Gender**: Male/Female/Both

### Dialogue Editor Buttons

| Button | Function |
|--------|----------|
| **New Node** | Create a blank dialogue node |
| **Delete Node** | Remove selected node |
| **Move Up/Down** | Reorder nodes |
| **Link to Dialogue** | Create a link to another dialogue using a global variable |
| **Generate Speech** | Generate voice-over WAV file using SAPI5 |
| **Remove Blank Nodes** | Delete nodes with no text and no options |

### Node Actions

The **Node actions** field lets you attach script side effects to a dialogue node (similar to NPC text actions). Use the same 2-letter code syntax as player options.

### AI Generation Tab

See [AI Dialogue Generator](#ai-dialogue-generator) for details.

---

## MES Editors

ScriptEd ships with several editors for MES (message) files.

### Generic MES Editor

Access via **Script > Game Text** submenu.

- Displays all entries in the selected MES file
- Edit text directly in the list
- Save changes back to the file

### Quest Editor

**Access:** **Script > Quests > Quest Entries...**

Displays quests from `Quests.mes` and `QuestEntries.mes`:

- **Smart log**: Detailed quest description
- **Dumb log**: Short quest name
- **Quest ID**: Integer identifier
- **XP reward**: Experience points on completion

> **Note:** Quests must exist in the master `gamequest` list. Missing entries are shown as `<missing>` in the editor.

### Journal Editor

**Access:** **Script > Edit journal entries...**

Manages `Journal.mes` - the in-game journal text.

### MES File Header Editor

For MES files with custom header blocks (e.g., `AttachmentPointDesc.mes`).

---

## AI Dialogue Generator

### Overview

The Dialogue Generator uses [Ollama](https://ollama.com/) to create dialogue content with AI. Three modes are available:

### NPC Response

Generates an in-character NPC reply.

1. Enter a **Node Description** (who is speaking, context)
2. Enter the **Player Text** (what the PC just said)
3. Click **Generate**
4. Review the AI-generated response
5. Click **Copy to Clipboard** or **Insert into Dialogue**

### Player Options

Generates 3 concise player dialogue options from context.

1. Enter **Context** (what's happening in the scene)
2. Click **Generate**
3. Review the 3 options
4. Click **Copy All to Clipboard** or **Insert into Dialogue**

The **"Create Nodes & Options"** button goes further: it takes the AI-generated options (which include `=> NODE:<name>` suffixes) and automatically creates new dialogue nodes wired to the currently selected node.

### Journal Entry

Generates quest journal text.

1. Enter a **Topic** (what the journal entry is about)
2. Choose **Smart** (detailed) or **Dumb** (simple) tone
3. Click **Generate**
4. Copy or insert the result

### Requirements

- Ollama must be running (local) or accessible (cloud)
- A model must be pulled (e.g., `ollama pull mistral:7b`)
- Ollama integration must be enabled in Preferences

> **Performance note:** Generation speed depends on your hardware. On a Ryzen 5600X + GTX 1070 + 16 GB DDR4, `mistral:7b` takes 30 s to a minute. Sub-7B models are much faster and recommended for rapid iteration.

---

## Plugin System

### Overview

ScriptEd supports plugins in three categories:

- **PLG_*** - General-purpose plugins
- **DEV_*** - Developer/debugging tools
- **DLG_*** - Dialogue editor extensions

Plugins are loaded from the `plugins\` directory at startup.

### Plugin API

Plugins must export the following functions:

```pascal
// Required
function GetPluginName: PChar; stdcall;
function GetPluginDescription: PChar; stdcall;
function GetInterfaceVersion: PChar; stdcall;

// Optional
function CanAddToMenu: Boolean; stdcall;
function GetKeyShortCut: ShortString; stdcall;
procedure RunPlugin(BasePath: PChar); stdcall;
procedure PluginConfig(BasePath: PChar); stdcall;
procedure GenerateSpeech(Male, Female, Voice, Output: PChar; Line: Integer); stdcall;
procedure PluginClose; stdcall;
procedure PluginUpdate; stdcall;
procedure DebugIntercept(Msg: PChar); stdcall;
procedure ImportData(FileName: ShortString); stdcall;
```

### Plugin Registration

When a plugin is loaded:

1. `GetPluginName` and `GetPluginDescription` are called
2. If `CanAddToMenu` returns `True`, the plugin appears in the Plugins menu
3. `GetInterfaceVersion` is checked against the minimum version (1.50)
4. `GetFilter` (if present) extends the File Open dialog filter list
5. The DLL handle is released - it is reloaded on demand when the plugin is executed

> **Important:** All exported functions must use the `stdcall` calling convention. Failure to do so will result in crashes.

### Executing Plugins

- Click the plugin name in the **Plugins** menu
- If the plugin is not already loaded, it is loaded and `RunPlugin` is called
- If the plugin provides `GenerateSpeech`, the dialogue editor's "Generate Speech" button becomes active

### Plugin Error Handling

ScriptEd reports plugin errors consistently:

- **Load failures**: Error dialog with the filename
- **Missing exports**: Warning dialog identifying the missing function
- **Already running**: Warning dialog
- **Version mismatch**: Detailed explanation of expected vs. actual version

Debug-only diagnostic messages are written to the console/log, not shown as dialogs.

---

## Compilation Workflow

### Compiling a Script

1. Open or create a script in the editor
2. Press **F9** or click **Script > Compile**
3. ScriptEd parses the text into an internal binary representation
4. The binary is written to the `.scr` file
5. The editor refreshes to show the compiled result

### Compiler Log

The bottom pane shows compilation progress:

```
Script updated - 42 lines in script.
Operation took 0.01250 seconds to complete
```

Errors are shown in red:

```
Error: Line 15: Unknown opcode 'foobar'
```

### Line Number Remapping

When you insert or delete lines, GOTO targets can become invalid. ScriptEd can automatically remap line numbers:

- Enabled by default (**Edit > Preferences > Remap Line Numbers**)
- Tracks all GOTO references
- Adjusts targets when line count changes

### Saving

- **Ctrl+S**: Save to the current filename
- The title bar shows `*` when the script has unsaved changes
- On exit, you are prompted to save if the script is changed

---

## Preferences & Configuration

### Accessing Preferences

Click **Edit > Preferences** to open the Preferences window.

### General Settings

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| Auto Remap Line Numbers | Boolean | True | Automatically adjust GOTO targets after edits |
| Compile on Enter | Boolean | False | Compile when pressing Enter in editor |
| Verbose Debug | Boolean | False | Enable detailed debug logging |
| Auto-replace gender strings | Boolean | False | Sync "sir"/"madam" etc. based on PC gender |
| Auto-increment VO numbers | Boolean | True | Add VO numbers to new dialogue nodes |
| Line number step | Integer | 20 | Step size when adding new dialogue nodes |

### Ollama Settings

| Setting | Type | Description |
|---------|------|-------------|
| Enabled | Boolean | Master switch for AI features |
| Provider | Enum | `Local` or `OllamaCloud` |
| URL | String | API endpoint (default: `http://localhost:11434`) |
| API Key | String | Bearer token for OllamaCloud |
| Model | String | Model name (e.g., `mistral:7b`) |

### Storage

Settings are stored in `ScriptEd.ini` in the application directory using the JEDI `JvAppIniFileStorage` component.

Window positions, MRU lists, and form placements are persisted across runs.

---

## Troubleshooting

### Plugin not loading

**Symptoms:** Plugin does not appear in the Plugins menu, or an error dialog appears on startup.

**Solutions:**
- Ensure the plugin DLL is in the `plugins\` folder
- Verify the plugin exports `GetPluginName` and `GetPluginDescription`
- Check that the interface version is >= 1.50
- Look for error dialogs that identify the specific missing export

### Script fails to compile

**Symptoms:** Compiler log shows errors, script does not update.

**Solutions:**
- Check for typos in opcode names (use the code completion)
- Ensure all required parameters are present
- Verify that referenced line numbers exist
- Use **Script > Undo Compile** to restore the last working version
- Check that the `.mes` files in `data\` are accessible

### Dialogue editor crash

**Symptoms:** Access violation when closing the dialogue editor.

**Solutions:**
- Ensure you have a valid script loaded with a `.dlg` file
- Do not delete all nodes - leave at least one node
- If the crash persists, save your work and restart ScriptEd

### Ollama connection failed

**Symptoms:** "Ollama not running" message, or connection error.

**Solutions:**
- Verify Ollama is installed and running (`ollama serve`)
- Check the URL in Preferences (default: `http://localhost:11434`)
- For OllamaCloud, verify your API key
- Ensure your firewall allows the connection
- Pull a model first: `ollama pull mistral:7b`

### "Failed to get handle" error

**Symptoms:** Error dialog when trying to load a plugin.

**Solutions:**
- The plugin DLL may be corrupted or for a different architecture
- Check that dependent DLLs (if any) are in the same folder or PATH
- Try running as Administrator
- Check the debug log for the specific Windows error code

### General troubleshooting steps

1. **Check the compiler log** for detailed error messages
2. **Verify file paths** - Arcanum must be installed and the path set correctly
3. **Delete `ScriptEd.ini`** to reset preferences to defaults
4. **Run as Administrator** if you get permission errors
5. **Check the exception log** (`exceptionlog.txt`) for crash details
6. **Update JCL/JVCL** if you see component-related errors

---

## Reference

### File Extensions

| Extension | Description |
|-----------|-------------|
| `.scr` | Compiled script file (binary) |
| `.dlg` | Dialogue tree file (binary) |
| `.mes` | Message string table (text, indexed by integer) |
| `.dat` | DAT archive (contains game files) |
| `.dws` | DelphiWebScript II helper script |
| `.ini` | ScriptEd configuration file |

### Directory Structure

```
ScriptEd_v1_50/
├── ScriptEd.exe           <- main executable
├── ScriptEd.ini           <- user settings
├── plugins/
│   ├── PLG_*.dll          <- general plugins
│   ├── DEV_*.dll          <- developer tools
│   └── DLG_*.dll          <- dialogue editor plugins
├── data/
│   ├── action.mes         <- action opcode descriptions
│   ├── condition.mes      <- condition opcode descriptions
│   ├── focus.mes          <- NPC/item names
│   ├── value.mes          <- value type names
│   ├── AttachmentPoint.mes
│   ├── Stats.mes
│   └── ScriptCallType.mes
├── helperscripts/
│   ├── HelperScripts.dws  <- user helper scripts
│   └── ...
├── src/                   <- source code
│   ├── ScriptEd.dpr
│   ├── ScriptEdWindow.pas
│   ├── ArcanumSCRLib.pas
│   └── ...
├── changelog.md
└── readme.md
```

### Common Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+N` | New script |
| `Ctrl+O` | Open script |
| `Ctrl+S` | Save script |
| `F9` | Compile |
| `Ctrl+D` | Open dialogue editor |
| `Ctrl+Space` | Code completion |
| `Ctrl+Z` | Undo text changes |
| `Ctrl+Click` | Jump to line reference |

### Opcode Categories

#### Common Actions

| Opcode | Description | Parameters |
|--------|-------------|------------|
| `dialog` | Start dialogue | dialogue ID |
| `say` | NPC speaks | message ID |
| `give gold` | Give gold to triggerer | amount |
| `give item` | Give item to triggerer | item prototype ID, quantity |
| `set global flag` | Set a global flag | flag ID, value |
| `goto line` | Jump to script line | line number |
| `return` | End script, skip default | - |
| `attack` | Attack target | target object |
| `float line` | Show float message | message ID, above object |

#### Common Conditions

| Opcode | Description | Parameters |
|--------|-------------|------------|
| `global flag is set` | Check global flag | flag ID |
| `npc has met pc before` | Check if NPC knows PC | - |
| `npc is hostile to` | Check hostility | target object |
| `pc has item` | Check inventory | item prototype ID, quantity |
| `random` | Random chance | percentage (0-100) |
| `quest state` | Check quest status | quest ID, state |

### Error Codes

| Message | Meaning | Solution |
|---------|---------|----------|
| `Failed to get handle` | Plugin DLL could not be loaded | Check plugin path, architecture, dependencies |
| `Plugin already running` | Plugin instance is active | Close the plugin first, or restart ScriptEd |
| `Incompatible interface version` | Plugin is too old | Update the plugin or contact the author |
| `Did not find needed procedures` | Plugin is missing required exports | Reinstall or update the plugin |
| `Blank string for version` | Plugin returned invalid version | Plugin is corrupt - remove it |

---

## Getting Help

- **GitHub Issues**: Report bugs at `https://github.com/TimoP80/ScriptEd_v1_50/issues`
- **Forum**: Thread references in the changelog (e.g., "forum #41") point to the Modding/Arcanum community forum
- **Contributing**: See `GPL.txt` for license information

---

*This documentation was generated for ScriptEd v1.50-beta Build 10.*
