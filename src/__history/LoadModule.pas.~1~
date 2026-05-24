unit LoadModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ScriptEdConfig, masks, arcdatlib, arcanumscrlib, JclFileUtils,
  Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, JvComponentBase, JvChangeNotify, JvExControls, JvArrowButton,
  Menus;

type
  TForm6 = class(TForm)
    ListView1:        TListView;
    OKButton:         TButton;
    Button2:          TButton;
    waitpanel:        TPanel;
    Timer1:           TTimer;
    UncompressButton: TButton;
    JvChangeNotify1:  TJvChangeNotify;
    SaveDialog1:      TSaveDialog;
    CompressButton:   TJvArrowButton;
    PopupMenu1:       TPopupMenu;
    Standardmode1:    TMenuItem;
    Advancedmodesplitintopatchn1: TMenuItem;
    procedure ListView1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure UncompressButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JvChangeNotify1ChangeNotify(Sender: TObject; Dir: string;
      Actions: TJvChangeActions);
    procedure Standardmode1Click(Sender: TObject);
    procedure Advancedmodesplitintopatchn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6:           TForm6;
  notify:          TJvChangeItem;
  tempdathandle:   file;
  selectedmodule:  string;
  compressioninprogress: boolean;
  modulegetnotify: boolean;
  tempdatrec:      datfileheader;
  datcompressrec:  datfileheader;

procedure GetModules;

implementation

uses UncompressModule, AdvancedDATOptions;

{$R *.dfm}

procedure GetModules;
var
  datscriptcount, x, t: integer;
  ismoduleresource: boolean;
  item: TListItem;
  scripts: TStrings;
  modulelist: TStrings;
begin
  form6.waitpanel.Visible := True;
  modulelist := TStringList.Create;
  scripts := TStringList.Create;
  Form6.ListView1.Clear;
  AdvBuildFileList(arcanumpath + '\Modules\*', faDirectory, modulelist, amAny, []);
  modulelist.Delete(modulelist.IndexOf('..'));
  modulelist.Delete(modulelist.IndexOf('.'));
  for t := 0 to modulelist.Count - 1 do
  begin
    form6.waitpanel.Caption :=
      'Please wait... Gathering module data (' + modulelist[t] + ')';
    application.ProcessMessages;
    scripts.Clear;
    if (pos('.dat', modulelist[t]) = 0) and
      (pos('.patch', lowercase(modulelist[t])) = 0) then
    begin
      advbuildfilelist(arcanumpath + '\Modules\' + modulelist[t] +
        '\scr\*.scr', faAnyFile, scripts, amAny, []);
    end else
    begin
      if ShowCompressedModules = True then
      begin
        opendatfile(tempdathandle, tempdatrec, arcanumpath + '\Modules\' +
          modulelist[t]);
        datscriptcount := 0;
        for x := 0 to tempdatrec.filecount - 1 do
        begin
          if matchesmask(tempdatrec.files[x].filename, 'scr\*.scr') then
          begin
            Inc(datscriptcount);
          end;

        end;
        closedathandle(tempdathandle);
      end;

    end;

    if IsDirectory(arcanumpath + '\Modules\' + modulelist[t]) or
      (pos('.dat', modulelist[t]) <> 0) or
      (pos('.patch', lowercase(modulelist[t])) <> 0) then
      ismoduleresource := True
    else
      ismoduleresource := False;

    if ismoduleresource = True then
    begin
      if (showcompressedmodules = False) and
        ((pos('.dat', modulelist[t]) <> 0) or
        (pos('.patch', lowercase(modulelist[t])) <> 0)) then
      begin
        Consoledebug('Hidden - ' + modulelist[t]);
      end else
      begin
        item := Form6.ListView1.Items.Add;
        item.Caption := modulelist[t];
        if (pos('.dat', modulelist[t]) <> 0) or
          (pos('.patch', lowercase(modulelist[t])) <> 0) then
        begin
          if extractfileext(modulelist[t]) = '.dat' then
            item.SubItems.Add('Compressed')
          else
          if pos('.patch', lowercase(extractfileext(modulelist[t]))) <> 0 then
            item.SubItems.Add('Module patch');

          item.subitems.add(IntToStr(datscriptcount));
        end else
        begin
          item.SubItems.Add('Folder');
          item.subitems.add(IntToStr(scripts.Count));
        end;
      end;

    end;

  end;
  form6.waitpanel.Visible := False;
  modulegetnotify := False;
end;

procedure TForm6.ListView1DblClick(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TForm6.FormShow(Sender: TObject);
begin
  modulegetnotify := True;
  timer1.Enabled  := True;
end;

procedure TForm6.Timer1Timer(Sender: TObject);
begin
  if ModuleGetNotify = True then
  begin
    form6.timer1.Enabled := False;
    GetModules;
  end;

end;

procedure TForm6.ListView1Click(Sender: TObject);
begin
  if listview1.selected = nil then
  begin
    UncompressButton.Enabled := False;
    CompressButton.Enabled := False;
    exit;
  end;

  selectedmodule := listview1.selected.Caption;

  if pos('.dat', lowercase(listview1.selected.Caption)) <> 0 then
  begin
    UncompressButton.Enabled := True;
    CompressButton.Enabled := False;
  end else
  begin
    UncompressButton.Enabled := False;
    CompressButton.Enabled := True;
  end;

end;

procedure TForm6.UncompressButtonClick(Sender: TObject);
var
  t: integer;
begin
  opendatfile(tempdathandle, tempdatrec, arcanumpath + '\Modules\' +
    listview1.selected.Caption);
  form20.Caption := 'Uncompressing Module ' + listview1.selected.Caption;
  form20.Show;
  if directoryexists(arcanumpath + '\Modules\' +
    changefileext(listview1.selected.Caption, '')) = False then
  begin
    if CreateDir(arcanumpath + '\Modules\' +
      changefileext(listview1.selected.Caption, '')) = True then
    begin
      form20.uncompresslog.Lines.add('Created module folder ' +
        arcanumpath + '\Modules\' + changefileext(listview1.selected.Caption, ''));

    end else
    begin
      form20.uncompresslog.Lines.add('Unable to create module folder ' +
        arcanumpath + '\Modules\' + changefileext(listview1.selected.Caption, ''));
    end;

  end else
  begin
    form20.uncompresslog.Lines.add('Module folder already exists.');
  end;

  form20.progress.Max := tempdatrec.filecount;
  chdir(arcanumpath + '\Modules\' + changefileext(listview1.selected.Caption, ''));
  for t := 0 to tempdatrec.filecount - 1 do
  begin
    application.ProcessMessages;
    form20.progress.Position := t;
    if tempdatrec.files[t].itemtype = FILETYPE_CMP then
      form20.uncompresslog.Lines.Add('Decompressing file ' +
        tempdatrec.files[t].filename)
    else
    if tempdatrec.files[t].itemtype = FILETYPE_UNCMP then
      form20.uncompresslog.Lines.Add('Extracting file ' + tempdatrec.files[t].filename);

    if tempdatrec.files[t].itemtype <> FILETYPE_DIR then
      openfilefromdatwithfullpath(tempdathandle, tempdatrec,
        tempdatrec.files[t].filename);
  end;
  closedathandle(tempdathandle);
  chdir(extractfiledir(ParamStr(0)));
  case MessageDlg('Do you wish to delete the DAT archive?', mtConfirmation,
      [mbYes, mbNo], 0) of
    mrYes:
    begin
      DeleteFile(arcanumpath + '\Modules\' + listview1.selected.Caption);
    end;
  end;

end;

procedure TForm6.FormCreate(Sender: TObject);

begin
  SaveDialog1.InitialDir := arcanumpath + '\Modules';
  notify := form6.JvChangeNotify1.Notifications.Add;
  notify.Directory := arcanumpath + '\Modules';
  form6.JvChangeNotify1.Active := True;

end;

procedure TForm6.JvChangeNotify1ChangeNotify(Sender: TObject;
  Dir: string; Actions: TJvChangeActions);
begin
  // consoledebug('Changed: ' + dir+': '+ActionsToString(actions));
  if compressioninprogress = False then
  begin
    modulegetnotify := True;
    timer1.Enabled  := True;
  end;
end;

procedure TForm6.Standardmode1Click(Sender: TObject);
var
  x:  integer;
  fh: file;
  filename: string;
  dat_files: TStringList;
begin

  if savedialog1.Execute then
  begin
    messagelog := form20.uncompresslog.Lines;

    chdir(arcanumpath + '\Modules\' + listview1.selected.Caption);
    form20.Caption := 'Compressing Module ' + listview1.selected.Caption;
    create_dat_file(tempdathandle, datcompressrec, arcanumpath +
      '\Modules\' + extractfilename(SaveDialog1.filename));
    dat_files := TStringList.Create;
    AdvBuildFileList(arcanumpath + '\Modules\' + listview1.selected.Caption +
      '\*', faAnyFile, dat_files,
      amAny, [flRecursive, flFullNames]);
    dat_files.Sorted := True;
    form20.Show;
    form20.progress.Max := dat_files.Count;
    for x := 0 to dat_files.Count - 1 do
    begin
      if (pos('..', dat_files[x]) = 0) then
      begin

        form20.progress.Position := x;
        if IsDirectory(dat_files[x]) = False then
        begin
          filename := dat_files[x];
          filename := ExtractRelativePath(arcanumpath + '\Modules\' +
            listview1.selected.Caption + '\', dat_files[x]);
          add_file_to_dat(tempdathandle, datcompressrec, filename);
        end;

      end;

    end;
    write_dat_Header(tempdathandle, datcompressrec);
    closedathandle(tempdathandle);

    form20.hide;


    messagelog := nil;
  end;

end;

procedure TForm6.Advancedmodesplitintopatchn1Click(Sender: TObject);
var
  z, i, x: integer;
  fh: file;
  datbase: string;
  filename: string;
  dat_files: TStringList;
begin
  getfolders;
  form22.showmodal;
  if form22.modalresult = mrOk then
  begin

    if savedialog1.Execute then
    begin
      messagelog := form20.uncompresslog.Lines;
      datbase := extractfilename(changefileext(savedialog1.FileName, ''));
      chdir(arcanumpath + '\Modules\' + listview1.selected.Caption);
      form20.Caption := 'Compressing Module ' + listview1.selected.Caption;
      form20.Show;
      compressioninprogress := True;
      for z := 0 to groupcnt - 1 do
      begin
        form20.progressphase.Caption :=
          'Creating file ' + datbase + '.' + split_groups[z].extension;
        application.ProcessMessages;
        form20.uncompresslog.Lines.add('Creating split group file ' +
          arcanumpath + '\Modules\' + datbase + '.' + split_groups[z].extension);
        datcompressrec.dirtreesize := 0;
        create_dat_file(tempdathandle, datcompressrec, arcanumpath +
          '\Modules\' + datbase + '.' + split_groups[z].extension);
        consoledebug('DATCOMPRESREC_DIRTREESIZE==' +
          IntToStr(datcompressrec.dirtreesize));
        dat_files := TStringList.Create;
        for i := 0 to split_groups[z].folders.Count - 1 do
        begin
          dat_files.Clear;
          AdvBuildFileList(arcanumpath + '\Modules\' + listview1.selected.Caption +
            '\' + split_groups[z].folders[i] + '\*',
            faAnyFile, dat_files,
            amAny, [flFullNames]);
          dat_files.Sorted := True;
          form20.progress.Max := dat_files.Count;
          for x := 0 to dat_files.Count - 1 do
          begin
            if (pos('..', dat_files[x]) = 0) then
            begin

              form20.progress.Position := x;
              if IsDirectory(dat_files[x]) = False then
              begin
                filename := dat_files[x];
                filename := ExtractRelativePath(arcanumpath + '\Modules\' +
                  listview1.selected.Caption + '\', dat_files[x]);
                add_file_to_dat(tempdathandle, datcompressrec, filename);
              end;

            end;

          end;
        end;
        write_dat_Header(tempdathandle, datcompressrec);
        closedathandle(tempdathandle);

        //   form20.hide;
      end;
      compressioninprogress := False;

      messagelog := nil;
    end;

  end;

end;

end.
