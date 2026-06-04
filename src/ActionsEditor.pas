unit ActionsEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Mask, JvExMask, JvSpin,
  DialogueOpCodes;

type
  TDialogueEditorMode = (demTest, demResult);

  TForm28 = class(TForm)
    HeaderLabel: TLabel;
    CodeList: TListView;
    DetailLabel: TLabel;
    DetailMemo: TMemo;
    Num1Label: TLabel;
    Num1Edit: TJvSpinEdit;
    Num2Label: TLabel;
    Num2Edit: TJvSpinEdit;
    CurrentFieldLabel: TLabel;
    CurrentFieldMemo: TMemo;
    PreviewLabel: TLabel;
    PreviewValue: TLabel;
    InsertButton: TButton;
    ReplaceButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CodeListClick(Sender: TObject);
    procedure CodeListDblClick(Sender: TObject);
    procedure Num1EditChange(Sender: TObject);
    procedure Num2EditChange(Sender: TObject);
    procedure CurrentFieldMemoChange(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure ReplaceButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    FOpcodes: TDialogueOpCodeSet;
    FMode: TDialogueEditorMode;
    FCurrentCode: TDialogueOpCode;
    FHasCurrentCode: Boolean;
    procedure PopulateList;
    procedure UpdatePreview;
    procedure UpdateNumFields;
    function GetActiveCodeArray: TDialogueOpCodeArray;
  public
    // Caller sets these before calling ShowModal:
    //   EditMode      - test field (demTest) or result field (demResult)
    //   InitialValue  - the current contents of the field being edited
    // After ShowModal returns, check ModalResult and read NewValue.
    EditMode: TDialogueEditorMode;
    InitialValue: string;
    NewValue: string;
  end;

procedure EditDialogueField(var AValue: string; AMode: TDialogueEditorMode);

var
  Form28: TForm28;

implementation

{$R *.dfm}

procedure EditDialogueField(var AValue: string; AMode: TDialogueEditorMode);
begin
  // Convenience entry point so callers do not have to wire the form
  // directly.  Keeps the form instance off the caller's plate.
  if not Assigned(Form28) then
    Form28 := TForm28.Create(Application);
  Form28.EditMode := AMode;
  Form28.InitialValue := AValue;
  Form28.NewValue := AValue;
  if Form28.ShowModal = mrOk then
    AValue := Form28.NewValue;
end;

function TForm28.GetActiveCodeArray: TDialogueOpCodeArray;
begin
  if FMode = demTest then
    Result := FOpcodes.TestCodes
  else
    Result := FOpcodes.ResultCodes;
end;

procedure TForm28.FormCreate(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
  Arr: TDialogueOpCodeArray;
begin
  FOpcodes := TDialogueOpCodeSet.Create;
  FMode := demTest;
  FHasCurrentCode := False;
  FCurrentCode.Code := '';
  FCurrentCode.ParamCount := 0;
  FCurrentCode.Description := '';
  FCurrentCode.Detail := '';

  // Configure the list view (done in code so the DFM stays plain).
  CodeList.ViewStyle := vsReport;
  CodeList.RowSelect := True;
  CodeList.ReadOnly := True;
  CodeList.Columns.Clear;
  with CodeList.Columns.Add do
  begin
    Caption := 'Code';
    Width := 50;
  end;
  with CodeList.Columns.Add do
  begin
    Caption := '#';
    Width := 24;
  end;
  with CodeList.Columns.Add do
  begin
    Caption := 'Description';
    Width := 260;
  end;

  // Spin edits: num1 always present, num2 enabled only when needed.
  Num1Edit.MinValue := -99999;
  Num1Edit.MaxValue := 99999;
  Num1Edit.Value := 0;
  Num2Edit.MinValue := -99999;
  Num2Edit.MaxValue := 99999;
  Num2Edit.Value := 0;
  Num1Edit.Enabled := False;
  Num2Edit.Enabled := False;

  // Populate the list with test codes by default; FormShow will refresh
  // once EditMode has been applied by the caller.
  Arr := GetActiveCodeArray;
  for i := 0 to Length(Arr) - 1 do
  begin
    Item := CodeList.Items.Add;
    Item.Caption := Arr[i].Code;
    Item.SubItems.Add(IntToStr(Arr[i].ParamCount));
    Item.SubItems.Add(Arr[i].Description);
    Item.Data := Pointer(NativeInt(i));
  end;
end;

procedure TForm28.FormShow(Sender: TObject);
begin
  FMode := EditMode;
  if FMode = demTest then
    HeaderLabel.Caption :=
      'Dialogue Test Editor - {Test} field codes (one per line, joined with commas)'
  else
    HeaderLabel.Caption :=
      'Dialogue Result Editor - {Result} field codes (one per line, joined with commas)';

  // Refresh the list to match the mode.
  CodeList.Items.Clear;
  PopulateList;
  if CodeList.Items.Count > 0 then
  begin
    CodeList.ItemIndex := 0;
    CodeListClick(nil);
  end;

  CurrentFieldMemo.Text := InitialValue;
  UpdatePreview;
end;

procedure TForm28.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FOpcodes);
end;

procedure TForm28.PopulateList;
var
  i: Integer;
  Item: TListItem;
  Arr: TDialogueOpCodeArray;
begin
  Arr := GetActiveCodeArray;
  for i := 0 to Length(Arr) - 1 do
  begin
    Item := CodeList.Items.Add;
    Item.Caption := Arr[i].Code;
    Item.SubItems.Add(IntToStr(Arr[i].ParamCount));
    Item.SubItems.Add(Arr[i].Description);
    Item.Data := Pointer(NativeInt(i));
  end;
end;

procedure TForm28.CodeListClick(Sender: TObject);
var
  i: Integer;
  Arr: TDialogueOpCodeArray;
begin
  if CodeList.ItemIndex < 0 then
  begin
    FHasCurrentCode := False;
    DetailMemo.Clear;
    UpdateNumFields;
    UpdatePreview;
    Exit;
  end;
  i := NativeInt(CodeList.Items[CodeList.ItemIndex].Data);
  Arr := GetActiveCodeArray;
  if (i < 0) or (i >= Length(Arr)) then
  begin
    FHasCurrentCode := False;
    DetailMemo.Clear;
    UpdateNumFields;
    UpdatePreview;
    Exit;
  end;
  FCurrentCode := Arr[i];
  FHasCurrentCode := True;
  DetailMemo.Text := FCurrentCode.Detail;
  // Reset numbers to sensible defaults when switching codes.
  if FCurrentCode.ParamCount >= 1 then
    Num1Edit.Value := 0
  else
    Num1Edit.Value := 0;
  if FCurrentCode.ParamCount >= 2 then
    Num2Edit.Value := 0;
  UpdateNumFields;
  UpdatePreview;
end;

procedure TForm28.CodeListDblClick(Sender: TObject);
begin
  // Convenience: double-click inserts and closes.
  InsertButtonClick(Sender);
end;

procedure TForm28.UpdateNumFields;
begin
  if FHasCurrentCode then
  begin
    Num1Edit.Enabled := FCurrentCode.ParamCount >= 1;
    Num2Edit.Enabled := FCurrentCode.ParamCount >= 2;
    Num1Label.Enabled := Num1Edit.Enabled;
    Num2Label.Enabled := Num2Edit.Enabled;
  end
  else
  begin
    Num1Edit.Enabled := False;
    Num2Edit.Enabled := False;
    Num1Label.Enabled := False;
    Num2Label.Enabled := False;
  end;
end;

procedure TForm28.Num1EditChange(Sender: TObject);
begin
  UpdatePreview;
end;

procedure TForm28.Num2EditChange(Sender: TObject);
begin
  UpdatePreview;
end;

procedure TForm28.CurrentFieldMemoChange(Sender: TObject);
begin
  UpdatePreview;
end;

procedure TForm28.UpdatePreview;
begin
  if FHasCurrentCode then
    PreviewValue.Caption := FOpcodes.FormatCode(FCurrentCode, Num1Edit.AsInteger,
      Num2Edit.AsInteger, '', True)
  else
    PreviewValue.Caption := '(select a code from the list)';
end;

procedure TForm28.InsertButtonClick(Sender: TObject);
begin
  if not FHasCurrentCode then
  begin
    MessageDlg('Please select a code from the list first.', mtWarning, [mbOK], 0);
    Exit;
  end;
  NewValue := FOpcodes.FormatCode(FCurrentCode, Num1Edit.AsInteger,
    Num2Edit.AsInteger, CurrentFieldMemo.Text, False);
  CurrentFieldMemo.Text := NewValue;
  ModalResult := mrOk;
end;

procedure TForm28.ReplaceButtonClick(Sender: TObject);
begin
  if not FHasCurrentCode then
  begin
    MessageDlg('Please select a code from the list first.', mtWarning, [mbOK], 0);
    Exit;
  end;
  NewValue := FOpcodes.FormatCode(FCurrentCode, Num1Edit.AsInteger,
    Num2Edit.AsInteger, CurrentFieldMemo.Text, True);
  CurrentFieldMemo.Text := NewValue;
  ModalResult := mrOk;
end;

procedure TForm28.CancelButtonClick(Sender: TObject);
begin
  NewValue := InitialValue;
  ModalResult := mrCancel;
end;

end.
