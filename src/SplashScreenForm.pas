unit SplashScreenForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, jpeg, pngimage;

type
  TSplashForm = class(TForm)
    Image1: TImage;
    BottomPanel: TPanel;
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
var
  imgPath: string;
  baseDir: string;
begin
  FClosing := False;
  BorderStyle := bsNone;
  FormStyle := fsStayOnTop;

  // Load the splash image from disk. Search both the EXE directory and
  // a sibling 'src' subdirectory, because the project outputs the EXE
  // to the project root but the image lives in 'src\'.
  Image1.Align := alClient;
  Image1.Center := True;
  Image1.Proportional := True;
  Image1.Stretch := True;

  baseDir := ExtractFilePath(ParamStr(0));
  imgPath := baseDir + 'SplashIMG.png';
  if not FileExists(imgPath) then
  begin
    // Try one level up (e.g. when EXE is in src\, the image might be in \)
    imgPath := baseDir + '..\SplashIMG.png';
    if not FileExists(imgPath) then
    begin
      // Try a sibling 'src' directory (e.g. when EXE is in project root)
      imgPath := baseDir + 'src\SplashIMG.png';
      if not FileExists(imgPath) then
        imgPath := '';
    end;
  end;

  if imgPath <> '' then
  begin
    try
      Image1.Picture.LoadFromFile(imgPath);
    except
      on E: Exception do
        Image1.Picture := nil;
    end;
  end;

  // Size the form to the image (or to a default if no image was loaded).
  if Image1.Picture.Graphic <> nil then
  begin
    // Add 40px to the height for the status / progress bar panel.
    ClientWidth := Image1.Picture.Width;
    ClientHeight := Image1.Picture.Height + 40;
  end
  else
  begin
    ClientWidth := 640;
    ClientHeight := 480;
  end;

  // Cap the form size to the working screen so very large splash images
  // do not push the form off-screen on low-resolution displays.
  if ClientWidth > Screen.WorkAreaWidth then
    ClientWidth := Screen.WorkAreaWidth;
  if ClientHeight > Screen.WorkAreaHeight then
    ClientHeight := Screen.WorkAreaHeight;

  // Explicitly center on the primary monitor. Setting Position to
  // poScreenCenter in the DFM alone is not always honoured when the
  // form is created with a non-zero Left/Top inherited from a previous
  // design session, so we recompute it here.
  Left := Screen.WorkAreaLeft + (Screen.WorkAreaWidth - Width) div 2;
  Top := Screen.WorkAreaTop + (Screen.WorkAreaHeight - Height) div 2;
  Position := poDesigned;

  // The bottom panel is fixed-height (40px) at the bottom of the form.
  BottomPanel.Align := alBottom;
  BottomPanel.Height := 40;
  BottomPanel.ParentBackground := False;
  BottomPanel.Color := clBlack;
  BottomPanel.BevelOuter := bvNone;

  StatusLabel.Caption := '';
  StatusLabel.Font.Color := clWhite;
  StatusLabel.Font.Name := 'Segoe UI';
  StatusLabel.Font.Size := 9;
  StatusLabel.Align := alTop;
  StatusLabel.Height := 20;

  ProgressBar1.Align := alClient;
  ProgressBar1.Visible := False;
end;

procedure TSplashForm.ShowSplash;
begin
  if not SplashVisible then
  begin
    Visible := True;
    Refresh;
    Application.ProcessMessages;
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
  if (Self = nil) or (StatusLabel = nil) or (csDestroying in ComponentState) then
    Exit;
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
