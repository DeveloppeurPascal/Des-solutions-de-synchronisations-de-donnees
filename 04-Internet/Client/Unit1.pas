unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  FMX.Bind.Grid, System.Bindings.Outputs, FMX.Bind.Editors,
  FMX.Layouts, FMX.ExtCtrls, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope, FMX.ScrollBox, FMX.Grid, FireDAC.Stan.StorageJSON, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Memo;

type
  TForm1 = class(TForm)
    btnLoadTable: TButton;
    FDMemTable1: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    StringGrid1: TStringGrid;
    btnLoadFile: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    ImageViewer1: TImageViewer;
    btnSendFile: TButton;
    Memo1: TMemo;
    procedure btnLoadFileClick(Sender: TObject);
    procedure btnLoadTableClick(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

Uses System.Net.HttpClient, System.Net.Mime;

procedure TForm1.btnLoadFileClick(Sender: TObject);
begin
  btnLoadFile.Enabled := false;
  tthread.CreateAnonymousThread(
    procedure
    begin
      var
      serveur := thttpclient.create;
      try
        serveur.UserAgent := 'MonProgrammeClient';
        var
        reponse := serveur.get('http://localhost:8080/apiGet');
        try
          if (reponse.StatusCode = 200) then
            tthread.Synchronize(nil,
              procedure
              begin
                ImageViewer1.Bitmap.LoadFromStream(reponse.ContentStream);
              end);
        finally
          freeandnil(reponse);
        end;
      finally
        freeandnil(serveur);
      end;
    end).Start;
end;

procedure TForm1.btnLoadTableClick(Sender: TObject);
begin
  btnLoadTable.Enabled := false;
  tthread.CreateAnonymousThread(
    procedure
    begin
      var
      serveur := thttpclient.create;
      try
        serveur.UserAgent := 'MonProgrammeClient';
        var
        reponse := serveur.get('http://localhost:8080/apiGetDB');
        try
          if (reponse.StatusCode = 200) then
            tthread.Synchronize(nil,
              procedure
              begin
                FDMemTable1.LoadFromStream(reponse.ContentStream,
                  TFDStorageformat.sfJSON);
              end);
        finally
          freeandnil(reponse);
        end;
      finally
        freeandnil(serveur);
      end;
    end).Start;
end;

procedure TForm1.btnSendFileClick(Sender: TObject);
begin
  btnSendFile.Enabled := false;
  tthread.CreateAnonymousThread(
    procedure
    begin
      var
      serveur := thttpclient.create;
      try
        serveur.UserAgent := 'MonProgrammeClient';
        serveur.ContentType := 'multipart/form-data';
        var
        post_param := tmultipartformdata.create;
        try
          post_param.AddFile('ImageMascotte',
            '../../Delphi-10_3-Rio-mascotte-2162x2485.png');
          var
          reponse := serveur.post('http://localhost:8080/apiPost', post_param);
          try
            if (reponse.StatusCode = 200) then
              tthread.Synchronize(nil,
                procedure
                begin
                  Memo1.Lines.LoadFromStream(reponse.ContentStream);
                end)
            else
              Memo1.Lines.Add('erreur');
          finally
            freeandnil(reponse);
          end;
        finally
          freeandnil(post_param);
        end;
      finally
        freeandnil(serveur);
      end;
    end).Start;
end;

end.
