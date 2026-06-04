unit SplashScreenForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, pngimage;

type
  TSplashForm = class(TForm)
    Image1: TImage;
    StatusLabel: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    FClosing: Boolean;
  public
    procedure UpdateStatus(const Msg: string);
    procedure UpdateProgress(Pos, Max: Integer);
    procedure ShowSplash;
    procedure HideSplash;
  end;

var
  SplashForm: TSplashForm;
  SplashVisible: Boolean = False;

implementation

{$R *.dfm}

procedure TSplashForm.FormCreate(Sender: TObject);
begin
  FClosing := False;
  Position := poScreenCenter;
  BorderStyle := bsNone;

  if FileExists(ExtractFilePath(ParamStr(0)) + 'SplashIMG.png') then
  begin
    Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SplashIMG.png');
  end;

  if Image1.Picture.Graphic <> nil then
    ClientWidth := Image1.Picture.Width
  else
    ClientWidth := 500;

  Image1.Align := alClient;
  StatusLabel.Align := alBottom;
  StatusLabel.Height := 20;
  ProgressBar1.Align := alBottom;

  StatusLabel.Caption := '';
  StatusLabel.Font.Color := clWhite;
  StatusLabel.Font.Name := 'Segoe UI';
  StatusLabel.Font.Size := 9;

  ProgressBar1.Visible := False;
end;

procedure TSplashForm.ShowSplash;
begin
  if not SplashVisible then
  begin
    ShowWindow(Handle, SW_SHOW);
    UpdateWindow(Handle);
    Update;
    SplashVisible := True;
  end;
end;

procedure TSplashForm.HideSplash;
begin
  if SplashVisible then
  begin
    Close;
    SplashVisible := False;
  end;
end;

procedure TSplashForm.UpdateStatus(const Msg: string);
begin
  StatusLabel.Caption := Msg;
  StatusLabel.Update;
  Application.ProcessMessages;
end;

procedure TSplashForm.UpdateProgress(Pos, Max: Integer);
begin
  if Max > 0 then
  begin
    ProgressBar1.Max := Max;
    ProgressBar1.Position := Pos;
    ProgressBar1.Visible := True;
    ProgressBar1.Update;
  end
  else
    ProgressBar1.Visible := False;
  Application.ProcessMessages;
end;

end.
