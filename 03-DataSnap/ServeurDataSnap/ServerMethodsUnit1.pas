unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, Data.DBXInterBase, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider, Datasnap.DSMetadata,
  Datasnap.DSConnectionMetaDataProvider;

type
  TServerMethods1 = class(TDSServerModule)
    EmployeeConnection: TSQLConnection;
    CountryTable: TSQLDataSet;
    DSCountryTable: TDataSetProvider;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function MaFonction: string;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.MaFonction: string;
begin
  Result := 'coucou';
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.
