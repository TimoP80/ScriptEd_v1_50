
{****************************************************************************************}
{                                                                                        }
{                                    XML Data Binding                                    }
{                                                                                        }
{         Generated on: 23.7.2008 1:26:49                                                }
{       Generated from: M:\Sierra\Arcanum\modules\Payback_Time\CompressionSettings.xml   }
{   Settings stored in: M:\Sierra\Arcanum\modules\Payback_Time\CompressionSettings.xdb   }
{                                                                                        }
{****************************************************************************************}

unit CompressionSettings;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLCompressionSettingsType = interface;
  IXMLSplitGroupType = interface;
  IXMLFoldersType = interface;

{ IXMLCompressionSettingsType }

  IXMLCompressionSettingsType = interface(IXMLNodeCollection)
    ['{EC27B773-247B-47B0-9CB0-6A7FE72A1118}']
    { Property Accessors }
    function Get_SplitGroup(Index: Integer): IXMLSplitGroupType;
    { Methods & Properties }
    function Add: IXMLSplitGroupType;
    function Insert(const Index: Integer): IXMLSplitGroupType;
    property SplitGroup[Index: Integer]: IXMLSplitGroupType read Get_SplitGroup; default;
  end;

{ IXMLSplitGroupType }

  IXMLSplitGroupType = interface(IXMLNode)
    ['{DD768CBE-3731-4336-9253-4F22B7AB5C2D}']
    { Property Accessors }
    function Get_Ext: WideString;
    function Get_Folders: IXMLFoldersType;
    procedure Set_Ext(Value: WideString);
    { Methods & Properties }
    property Ext: WideString read Get_Ext write Set_Ext;
    property Folders: IXMLFoldersType read Get_Folders;
  end;

{ IXMLFoldersType }

  IXMLFoldersType = interface(IXMLNodeCollection)
    ['{A7A9DA22-3D4B-45C0-AE74-C1D9E863D8F3}']
    { Property Accessors }
    function Get_Folder(Index: Integer): WideString;
    { Methods & Properties }
    function Add(const Folder: WideString): IXMLNode;
    function Insert(const Index: Integer; const Folder: WideString): IXMLNode;
    property Folder[Index: Integer]: WideString read Get_Folder; default;
  end;

{ Forward Decls }

  TXMLCompressionSettingsType = class;
  TXMLSplitGroupType = class;
  TXMLFoldersType = class;

{ TXMLCompressionSettingsType }

  TXMLCompressionSettingsType = class(TXMLNodeCollection, IXMLCompressionSettingsType)
  protected
    { IXMLCompressionSettingsType }
    function Get_SplitGroup(Index: Integer): IXMLSplitGroupType;
    function Add: IXMLSplitGroupType;
    function Insert(const Index: Integer): IXMLSplitGroupType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSplitGroupType }

  TXMLSplitGroupType = class(TXMLNode, IXMLSplitGroupType)
  protected
    { IXMLSplitGroupType }
    function Get_Ext: WideString;
    function Get_Folders: IXMLFoldersType;
    procedure Set_Ext(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFoldersType }

  TXMLFoldersType = class(TXMLNodeCollection, IXMLFoldersType)
  protected
    { IXMLFoldersType }
    function Get_Folder(Index: Integer): WideString;
    function Add(const Folder: WideString): IXMLNode;
    function Insert(const Index: Integer; const Folder: WideString): IXMLNode;
  public
    procedure AfterConstruction; override;
  end;

{ Global Functions }

function GetCompressionSettings(Doc: IXMLDocument): IXMLCompressionSettingsType;
function LoadCompressionSettings(const FileName: WideString): IXMLCompressionSettingsType;
function NewCompressionSettings: IXMLCompressionSettingsType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetCompressionSettings(Doc: IXMLDocument): IXMLCompressionSettingsType;
begin
  Result := Doc.GetDocBinding('CompressionSettings', TXMLCompressionSettingsType, TargetNamespace) as IXMLCompressionSettingsType;
end;

function LoadCompressionSettings(const FileName: WideString): IXMLCompressionSettingsType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('CompressionSettings', TXMLCompressionSettingsType, TargetNamespace) as IXMLCompressionSettingsType;
end;

function NewCompressionSettings: IXMLCompressionSettingsType;
begin
  Result := NewXMLDocument.GetDocBinding('CompressionSettings', TXMLCompressionSettingsType, TargetNamespace) as IXMLCompressionSettingsType;
end;

{ TXMLCompressionSettingsType }

procedure TXMLCompressionSettingsType.AfterConstruction;
begin
  RegisterChildNode('SplitGroup', TXMLSplitGroupType);
  ItemTag := 'SplitGroup';
  ItemInterface := IXMLSplitGroupType;
  inherited;
end;

function TXMLCompressionSettingsType.Get_SplitGroup(Index: Integer): IXMLSplitGroupType;
begin
  Result := List[Index] as IXMLSplitGroupType;
end;

function TXMLCompressionSettingsType.Add: IXMLSplitGroupType;
begin
  Result := AddItem(-1) as IXMLSplitGroupType;
end;

function TXMLCompressionSettingsType.Insert(const Index: Integer): IXMLSplitGroupType;
begin
  Result := AddItem(Index) as IXMLSplitGroupType;
end;

{ TXMLSplitGroupType }

procedure TXMLSplitGroupType.AfterConstruction;
begin
  RegisterChildNode('Folders', TXMLFoldersType);
  inherited;
end;

function TXMLSplitGroupType.Get_Ext: WideString;
begin
  Result := AttributeNodes['ext'].Text;
end;

procedure TXMLSplitGroupType.Set_Ext(Value: WideString);
begin
  SetAttribute('ext', Value);
end;

function TXMLSplitGroupType.Get_Folders: IXMLFoldersType;
begin
  Result := ChildNodes['Folders'] as IXMLFoldersType;
end;

{ TXMLFoldersType }

procedure TXMLFoldersType.AfterConstruction;
begin
  ItemTag := 'Folder';
  ItemInterface := IXMLNode;
  inherited;
end;

function TXMLFoldersType.Get_Folder(Index: Integer): WideString;
begin
  Result := List[Index].Text;
end;

function TXMLFoldersType.Add(const Folder: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := Folder;
end;

function TXMLFoldersType.Insert(const Index: Integer; const Folder: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := Folder;
end;

end. 