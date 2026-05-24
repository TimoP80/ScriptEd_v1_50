unit SpeechGenInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  JclShell, lame, arcanumscrlib, pluginapi, Dialogs, StdCtrls,
  ComCtrls, ACS_Classes, ACS_Converters, ACS_LAME, ACS_Wave,
  AdvSmoothStatusIndicator;

type
  TForm23 = class(TForm)
    Label1:      TLabel;
    outputpath:  TLabel;
    Label3:      TLabel;
    Label4:      TLabel;
    maletext:    TMemo;
    femaletext:  TMemo;
    Label5:      TLabel;
    VoiceList:   TComboBox;
    Button1:     TButton;
    Button2:     TButton;
    Label2:      TLabel;
    file_female: TLabel;
    file_male:   TLabel;
    WaveIn1:     TWaveIn;
    MP3Out1:     TMP3Out;
    AdvSmoothStatusIndicator1: TAdvSmoothStatusIndicator;
    AdvSmoothStatusIndicator2: TAdvSmoothStatusIndicator;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MP3Out1Done(Sender: TComponent);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form23:        TForm23;
  speechlinenum: integer;

procedure UpdateFileStatus;

implementation

uses ScriptEdWindow;

{$R *.dfm}

procedure UpdateFileStatus;
begin

  if fileexists(voicedir + '\' + changefileext(form23.file_male.Caption, '.mp3')) then
  begin
    form23.AdvSmoothStatusIndicator1.Caption := 'MP3';
  end;

  if fileexists(voicedir + '\' + changefileext(form23.file_male.Caption, '.mp3')) then
  begin
    form23.AdvSmoothStatusIndicator2.Caption := 'MP3';
  end;

  if fileexists(voicedir + '\' + form23.file_male.Caption) then
  begin
    form23.AdvSmoothStatusIndicator1.Caption := 'WAV';
  end else
  if (fileexists(voicedir + '\' + changefileext(form23.file_male.Caption, '.mp3')) =
    False) and (fileexists(voicedir + '\' + form23.file_male.Caption) = False) then
    form23.AdvSmoothStatusIndicator1.Caption := 'Not Recorded';


  if fileexists(voicedir + '\' + form23.file_female.Caption) then
  begin
    form23.AdvSmoothStatusIndicator2.Caption := 'WAV';
  end else
  if (fileexists(voicedir + '\' + changefileext(form23.file_female.Caption, '.mp3')) =
    False) and (fileexists(voicedir + '\' + form23.file_female.Caption) = False) then
    form23.AdvSmoothStatusIndicator2.Caption := 'Not Recorded';

end;

procedure TForm23.Button1Click(Sender: TObject);
var
  lres: boolean;
  outputmale, outputfemale: string;
var
  thecmdline: string;
  mp3outputmale, mp3outputfemale: string;
begin
  if femaletext.Text = '' then
  begin
    ExecuteSpeechGenerator('plugins\DLG_SpeechApi.dll', maletext.Text,
      '', VoiceList.Text, outputpath.Caption, speechlinenum);

    thecmdline := '-b 96 -m m ' + form23.file_male.Caption + ' ' +
      changefileext(form23.file_male.Caption, '.mp3');

    chdir(voicedir);
    consoledebug('Executing LAME.EXE => ' + thecmdline);
    lres := shellexecex('C:\CMDLineTools\lame.exe', thecmdline, '', SW_HIDE);


  end else
  begin

    ExecuteSpeechGenerator('plugins\DLG_SpeechApi.dll', maletext.Text,
      femaletext.Text, VoiceList.Text, outputpath.Caption, speechlinenum);
    thecmdline := '-b 96 -m m ' + form23.file_male.Caption + ' ' +
      changefileext(form23.file_male.Caption, '.mp3');

    chdir(voicedir);
    consoledebug('Executing LAME.EXE => ' + thecmdline);
    lres := shellexecex('C:\CMDLineTools\lame.exe', thecmdline, '', SW_HIDE);
    thecmdline := '-b 96 -m m ' + form23.file_female.Caption +
      ' ' + changefileext(form23.file_female.Caption, '.mp3');
    consoledebug('Executing LAME.EXE => ' + thecmdline);
    lres := shellexecex('C:\CMDLineTools\lame.exe', thecmdline, '', SW_HIDE);
    chdir(extractfiledir(ParamStr(0)));


  end;


  MessageDlg('Speech file generation complete!', mtInformation, [mbOK], 0);

    if fileexists(outputpath.Caption + '\' + form23.file_male.Caption) then DeleteFile(outputpath.Caption + '\' + form23.file_male.Caption);
    if fileexists(outputpath.Caption + '\' + form23.file_female.Caption) then DeleteFile(outputpath.Caption + '\' + form23.file_female.Caption);

  updatefilestatus;
end;

procedure TForm23.FormCreate(Sender: TObject);
begin
  ConsoleDebug('Lame loaded!');
end;

procedure TForm23.MP3Out1Done(Sender: TComponent);
begin
  ConsoleDebug('mp3 done');
end;

end.
