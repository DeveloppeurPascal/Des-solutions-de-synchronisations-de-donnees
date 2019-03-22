unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TWebModule1 = class(TWebModule)
    EmployeeConnection: TFDConnection;
    CountryTable: TFDQuery;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1DemandeDeFichierAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1EnvoiDeFichierAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModule1EnvoiBaseAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses System.IOUtils, Web.ReqMulti;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  // http://localhost:8080/
  Response.Content := '<html>' +
    '<head><title>Application Serveur Web</title></head>' +
    '<body>Application Serveur Web</body>' + '</html>';
end;

procedure TWebModule1.WebModule1DemandeDeFichierAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  // http://localhost:8080/apiGet
  Response.ContentType := 'image/png';
  Response.ContentStream :=
    tfile.OpenRead('../../Delphi-10_3-Rio-mascotte-2162x2485.png');
end;

procedure TWebModule1.WebModule1EnvoiBaseAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  // http://localhost:8080/apiGetDB
  Response.ContentType := 'application/json';
  Response.ContentStream := tmemorystream.Create;
  CountryTable.SaveToStream(Response.ContentStream, tfdstorageformat.sfJSON);
end;

procedure TWebModule1.WebModule1EnvoiDeFichierAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  erreur: integer;
  nom_fichier: string;
  i: integer;
  multireq: tmultipartcontentparser;
begin
  // http://localhost:8080/apiPost
  if (tmultipartcontentparser.CanParse(Request)) then
    try
      multireq := tmultipartcontentparser.Create(Request);
    finally
      freeandnil(multireq);
    end;
  Response.Content := '<html>' +
    '<head><title>Application Serveur Web</title></head>' + '<body>';
  for i := 0 to Request.Files.Count - 1 do
  begin
    Response.Content := Response.Content + '<p>' + Request.Files[i].FieldName +
      '=' + Request.Files[i].FileName + '</p>';
    (*
      tmemorystream(Request.Files[i].Stream)
      .SaveToFile(tpath.Combine('CheminDeStockageDesFichiersTransferes',
      'NomDuFichierSurLeServeur'));
    *)
  end;
  Response.Content := Response.Content + '</body>' + '</html>';
end;

// Liste des types mime : https://fr.wikipedia.org/wiki/Type_de_m%C3%A9dias

end.
