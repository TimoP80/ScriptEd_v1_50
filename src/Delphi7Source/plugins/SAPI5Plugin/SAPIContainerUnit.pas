unit SAPIContainerUnit;

interface

uses
  SysUtils, Classes, pluginfunc, SpeechLib_TLB, OleServer, ACS_Classes,
  ACS_LAME, ACS_Wave;

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
begin
  DebugMessage('Getting voices from API');
  zvoices := SpVoice1.GetVoices('', '');
  DebugMessage(PChar(IntToStr(zvoices.Count) + ' voices loaded.'));
end;

end.
