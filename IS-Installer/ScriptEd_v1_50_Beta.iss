[Files]
Source: "ScriptEd.exe"; DestDir: "{app}"
Source: "data\*.*"; DestDir: "{app}\data"
Source: "helperscripts\*.*"; DestDir: "{app}\helperscripts"
Source: "plugins\*.*"; DestDir: "{app}\plugins"
Source: "src\*.*"; DestDir: "{app}\src"; Flags: recursesubdirs; Components: src; Excludes: "*.dcu,*.exe, *.cfg, *.dof, *.ddp"
Source: "autocorrect.lst"; DestDir: "{app}"
Source: "HelperScripts.txt"; DestDir: "{app}"
Source: "changelog.md"; DestDir: "{app}"
Source: "readme.md"; DestDir: "{app}"; Flags: isreadme
Source: "dbmaker.exe"; DestDir: "{app}"
Source: "bass.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "ScriptCompiler.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "DejaVuSansMono.ttf"; DestDir: "{fonts}"

[Dirs]
Name: {app}\plugins
[INI]
Filename: {app}\ScriptEd.ini; Section: General; Key: AutoRemapScriptLines; String: 1
Filename: {app}\ScriptEd.ini; Section: General; Key: RemapLineNumbers; String: 0
Filename: {app}\ScriptEd.ini; Section: General; Key: PlayerOptionCommentEOL; String: 1
Filename: {app}\ScriptEd.ini; Section: General; Key: ShowCompressedModules; String: 0
Filename: {app}\ScriptEd.ini; Section: General; Key: DLGNodeNumberStep; String: 20

[Setup]
SourceDir=C:\CodeProjects\ScriptEd_v1_50
AppCopyright=© 2001-2020 T. Pitkänen
AppName=ScriptEd
AppVersion=ScriptEd v1.50-beta Build 10
;AppVerName=ScriptEd v1.50-beta Build 6
InfoBeforeFile=C:\CodeProjects\ScriptEd_v1_50\BuildChangeLog.txt
DefaultDirName={pf}\ScriptEd 1.50-beta
Compression=lzma/ultra64
OutputDir=C:\CodeProjects\ScriptEd_v1_50\IS-Installer
OutputBaseFilename=ScriptEd_1_50-beta-build10-setup
UsePreviousAppDir=false
AppID={{357A0514-605A-45F3-BE1D-FE44D57EB318}
DefaultGroupName=ScriptEd 1.50-beta

[Components]
Name: src; Description: Full source code including plugins; Types: custom
[Icons]
Name: {group}\ScriptEd; Filename: {app}\ScriptEd.exe; IconFilename: {app}\ScriptEd.exe; IconIndex: 0; WorkingDir: {app}
Name: {group}\Helper Scripts Command Reference; Filename: {app}\HelperScripts.txt
Name: {group}\Uninstall ScriptEd; Filename: {app}\unins000.exe; WorkingDir: {app}
