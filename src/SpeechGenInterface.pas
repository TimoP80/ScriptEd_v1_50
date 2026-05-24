unit SpeechGenInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  JclShell, arcanumscrlib, pluginapi, Dialogs, StdCtrls,
  ComCtrls,
  AdvSmoothStatusIndicator;

type
  TForm23 = class(TForm)
    Label1: TLabel;
    outputpath: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    maletext: TMemo;
    femaletext: TMemo;
    Label5: TLabel;
    VoiceList: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    file_female: TLabel;
    file_male: TLabel;
    AdvSmoothStatusIndicator1: TAdvSmoothStatusIndicator;
    AdvSmoothStatusIndicator2: TAdvSmoothStatusIndicator;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form23: TForm23;
  speechlinenum: integer;

procedure UpdateFileStatus;

implementation

uses ScriptEdWindow;

{$R *.dfm}

procedure UpdateFileStatus;
begin

  if fileexists(voicedir + '\' + changefileext(Form23.file_male.Caption, '.mp3'))
  then
  begin
    Form23.AdvSmoothStatusIndicator1.Caption := 'MP3';
  end;

  if fileexists(voicedir + '\' + changefileext(Form23.file_male.Caption, '.mp3'))
  then
  begin
    Form23.AdvSmoothStatusIndicator2.Caption := 'MP3';
  end;

  if fileexists(voicedir + '\' + Form23.file_male.Caption) then
  begin
    Form23.AdvSmoothStatusIndicator1.Caption := 'WAV';
  end
  else if (fileexists(voicedir + '\' + changefileext(Form23.file_male.Caption,
    '.mp3')) = False) and (fileexists(voicedir + '\' + Form23.file_male.Caption)
    = False) then
    Form23.AdvSmoothStatusIndicator1.Caption := 'Not Recorded';

  if fileexists(voicedir + '\' + Form23.file_female.Caption) then
  begin
    Form23.AdvSmoothStatusIndicator2.Caption := 'WAV';
  end
  else if (fileexists(voicedir + '\' + changefileext(Form23.file_female.Caption,
    '.mp3')) = False) and
    (fileexists(voicedir + '\' + Form23.file_female.Caption) = False) then
    Form23.AdvSmoothStatusIndicator2.Caption := 'Not Recorded';

end;

procedure TForm23.Button1Click(Sender: TObject);
var
  lres: boolean;
  outputmale, outputfemale: ansistring;
var
  thecmdline: string;
  mp3outputmale, mp3outputfemale: ansistring;
begin
  if femaletext.Text = '' then
  begin
    ExecuteSpeechGenerator('plugins\DLG_SpeechApi.dll', ansistring(maletext.Text), '',
      ansistring(VoiceList.Text), ansistring(outputpath.Caption), speechlinenum);

    thecmdline := '-b 96 -m m ' + Form23.file_male.Caption + ' ' +
      changefileext(Form23.file_male.Caption, '.mp3');

    chdir(voicedir);
    consoledebug('Executing LAME.EXE => ' + thecmdline);
    lres := shellexecex('C:\CMDLineTools\lame.exe', thecmdline, '', SW_HIDE);

  end
  else
  begin

    ExecuteSpeechGenerator('plugins\DLG_SpeechApi.dll', ansistring(maletext.Text),
      ansistring(femaletext.Text), ansistring(VoiceList.Text), ansistring(outputpath.Caption), speechlinenum);
    thecmdline := '-b 96 -m m ' + Form23.file_male.Caption + ' ' +
      changefileext(Form23.file_male.Caption, '.mp3');

    chdir(voicedir);
    consoledebug('Executing LAME.EXE => ' + thecmdline);
    lres := shellexecex('C:\CMDLineTools\lame.exe', thecmdline, '', SW_HIDE);
    thecmdline := '-b 96 -m m ' + Form23.file_female.Caption + ' ' +
      changefileext(Form23.file_female.Caption, '.mp3');
    consoledebug('Executing LAME.EXE => ' + thecmdline);
    lres := shellexecex('C:\CMDLineTools\lame.exe', thecmdline, '', SW_HIDE);
    chdir(extractfiledir(ParamStr(0)));

  end;

  MessageDlg('Speech file generation complete!', mtInformation, [mbOK], 0);

  if fileexists(outputpath.Caption + '\' + Form23.file_male.Caption) then
    DeleteFile(outputpath.Caption + '\' + Form23.file_male.Caption);
  if fileexists(outputpath.Caption + '\' + Form23.file_female.Caption) then
    DeleteFile(outputpath.Caption + '\' + Form23.file_female.Caption);

  UpdateFileStatus;
end;

end.
