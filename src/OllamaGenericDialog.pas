unit OllamaGenericDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  ScriptEdConfig, Vcl.Controls, Vcl.Forms, ScriptEdWindow, Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TForm30 = class(TForm)
    Label1: TLabel;
    ollamaprompt: TMemo;
    Label2: TLabel;
    ollamaresult: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form30: TForm30;
  theresponse: string;

implementation

{$R *.dfm}

uses ProgressDialogOllama;

procedure UpdateUI(const Response: string; const Error: string);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      if Error = '' then
      begin
        Form30.ollamaresult.text := Response;
        form31.Hide;
      end else
        ShowMessage('Error: ' + Error);
    end);
end;

procedure TForm30.Button3Click(Sender: TObject);
begin

  form31.Show;
  application.ProcessMessages;
  //ollamaresult.text := ollamarequest.GenerateText(ollamamodel, ollamaprompt.text);
  ollamarequest.GenerateTextAsync(ollamamodel, ollamaprompt.text,

    procedure(const Response: string; const Error: string)
    begin
      UpdateUI(Response, Error);
    end);


end;

end.
