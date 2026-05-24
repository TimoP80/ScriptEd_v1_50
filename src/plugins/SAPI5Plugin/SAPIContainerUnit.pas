unit SAPIContainerUnit;

interface

uses
  SysUtils, Classes, pluginfunc, SpeechLib_TLB, OleServer;

type
  TSAPIContainer = class(TDataModule)
    SpVoice1:       TSpVoice;
    SpFileStream1:  TSpFileStream;
    SpAudioFormat1: TSpAudioFormat;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SAPIContainer: TSAPIContainer;
  zthevoice:     ISpeechObjectToken;
  ispeechflags:  integer;
  zvoices:       Ispeechobjecttokens;

function FindVoice(Name: string): integer;

implementation

function FindVoice(Name: string): integer;
var
  u: integer;
begin
 for u := 0 to zvoices.Count - 1 do
  begin
    if Name = zvoices.Item(u).GetDescription(0) then
    begin
     Result := u;
      exit;
    end;
  end;
end;


{$R *.dfm}

procedure TSAPIContainer.DataModuleCreate(Sender: TObject);
var str: ansistring;
var z: Pansichar;
begin
  DebugMessage(pansichar('Getting voices from API'));
  zvoices := SpVoice1.GetVoices('', '');
str := Format('%d voices loaded',[zvoices.Count]);

  DebugMessage(pansichar(str));
end;

end.
