unit InterNPCDialogue;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  ScriptEdWindow, ArcanumSCRLib, DLgfileio, dlgparser, ScriptEdConfig, SelectScriptLine, ModuleScriptLoad, Vcl.Controls, Vcl.Forms, ModuleLoader, mesfileshow, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm29 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Label3: TLabel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label4: TLabel;
    Button7: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form29: TForm29;
  globalvar_dialogue: integer;
  globalvar_script: integer;
  dlgfilename: string;
  scrfilename: string;
  originalscript: string;
  dlgline: integer;
  scrline: integer;
  originaldlgfile: string;
// back up the dialogue pointer before parsing a new one
  dlgbackup: pdialoguefile;

implementation

{$R *.dfm}

uses GenericSelectorWindow;

procedure TForm29.Button1Click(Sender: TObject);
begin
  form16.Caption := 'Select Global Variable';
  form16.Label1.Caption := 'List of global vars in module "' +
    modulefolder + '"';
  fillindatafrommesfile(ScriptGlobalVars);
  form16.showmodal;
  if form16.modalresult = mrOk then
    globalvar_dialogue := ScriptGlobalVars.entries
      [form16.JvHTListBox1.itemindex].Index
  else if form16.modalresult = mrCancel then
    globalvar_dialogue := -1;

  Label1.Caption := inttostr(globalvar_dialogue);

end;

procedure TForm29.Button2Click(Sender: TObject);
begin
  form16.Caption := 'Select Global Variable';
  form16.Label1.Caption := 'List of global vars in module "' +
    modulefolder + '"';
  fillindatafrommesfile(ScriptGlobalVars);
  form16.showmodal;
  if form16.modalresult = mrOk then
    globalvar_script := ScriptGlobalVars.entries
      [form16.JvHTListBox1.itemindex].Index
  else if form16.modalresult = mrCancel then
    globalvar_script := -1;

  Label2.Caption := inttostr(globalvar_script);
end;

procedure TForm29.Button3Click(Sender: TObject);
begin
  originalscript:=selectedmodulescript;
  consoledebug('Previous dialogue is: '+changefileext(originalscript,'.dlg'));
  LoadModuleDialogueList;
  form10.showmodal;
  if form10.modalresult = mrOk then
  begin
    dlgfilename := selectedmodulescript;
    dlgfilename:=StringReplace(dlgfilename, 'scr','dlg',[rfReplaceAll]);
    scrfilename := selectedmodulescript;
    Label3.Caption := dlgfilename;
    Label6.caption := scrfilename;
  end
end;

procedure TForm29.Button6Click(Sender: TObject);
begin
form16.caption := 'Select dialogue line';
form16.Label1.Caption := 'List of dialogue lines in file '+dlgfilename;

 ChDir(arcanumpath + '\Modules\' + modulefolder + '\dlg');
    CurDLG.nodecount := 0;
  if fileexists(dlgfilename) then
    begin
      LoadDialogue(dlgfilename);
    end;

FillInDataFromDialogueFile(curdlg);
form16.ShowModal;
if form16.modalresult = mrOk then
begin
dlgline :=  curdlg.nodes[form16.JvHTListBox1.itemindex].start_index;

Label4.Caption := inttostr(dlgline);
ConsoleDebug('Restoring original dialogue...');
 // reload the original dialogue
ChDir(arcanumpath + '\Modules\' + modulefolder + '\dlg');
      LoadDialogue(changefileext(originalscript, '.dlg'));
      //consoledebug(
      ConsoleDebug('Dialogue restored...');

      end;



end;

procedure TForm29.Button7Click(Sender: TObject);
begin

  ShowScriptLines(arcanumpath+'\modules\'+modulefolder+'\scr\'+scrfilename);
  form19.showmodal;

  if form19.modalresult = mrOk then
  begin
   scrline := selectedline;
  end
  else
    scrline := -1;
     Label5.Caption := inttostr(scrline);
end;

end.
