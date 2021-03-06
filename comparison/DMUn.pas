unit DMUn;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.DB, Data.SqlExpr,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, SyncDiffUn;

type
  TDM = class(TDataModule, ISQLDiff)
    SQLConnection: TSQLConnection;
    SQLQuery: TSQLQuery;
    DataSetProvider: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(Aowner: TComponent; const aDatabase: string);
    function GetDataFromSQL(const aSQL: string): TClientDataSet;
    function ExecuteDirect(const aSQL: string): integer;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TDM.Create(Aowner: TComponent; const aDatabase: string);
begin
  inherited Create(AOwner);
  SQLConnection.DriverName := 'FireBird';
  SQLConnection.VendorLib := 'GDS32.dll';
  SQLConnection.LibraryName := 'dbxfb.dll';
  SQLConnection.ConnectionName := 'interf';
  SQLConnection.GetDriverFunc := 'getSQLDriverINTERBASE';
  SQLConnection.LoginPrompt := False;
  SQLConnection.Params.Values['Database'] := aDatabase;
  SQLConnection.ParamsLoaded := True;
  SQLConnection.Connected := True;
end;

function TDM.ExecuteDirect(const aSQL: string): integer;
begin
  Result := SQLConnection.ExecuteDirect(aSQL);
end;

function TDM.GetDataFromSQL(const aSQL: string): TClientDataSet;
begin
  Result := TClientDataSet.Create(Self);
  Result.CommandText := aSQL;
  Result.ProviderName := 'DataSetProvider';
  Result.Open;
end;

end.
