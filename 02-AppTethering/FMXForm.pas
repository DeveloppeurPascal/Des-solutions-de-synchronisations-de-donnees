unit FMXForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, FMX.Layouts,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls,
  FMX.ExtCtrls;

type
  TForm1 = class(TForm)
    ATManagerFMX: TTetheringManager;
    Memo1: TMemo;
    Layout1: TLayout;
    TetheringAppProfile1: TTetheringAppProfile;
    btnAutoConnect: TButton;
    ImageViewer1: TImageViewer;
    procedure ATManagerFMXRequestManagerPassword(const Sender: TObject;
      const ARemoteIdentifier: string; var Password: string);
    procedure btnAutoConnectClick(Sender: TObject);
    procedure ATManagerFMXPairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure TetheringAppProfile1Resources0ResourceReceived
      (const Sender: TObject; const AResource: TRemoteResource);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
    procedure TetheringAppProfile1AcceptResource(const Sender: TObject;
      const AProfileId: string; const AResource: TCustomRemoteItem;
      var AcceptResource: Boolean);
  private
    { Déclarations privées }
    procedure histo(ch: string);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

Uses System.IOUtils;

procedure TForm1.ATManagerFMXPairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  histo('Connecté avec ' + AManagerInfo.ManagerText + ' ' +
    AManagerInfo.ManagerName + ' ' + AManagerInfo.ManagerIdentifier);
end;

procedure TForm1.ATManagerFMXRequestManagerPassword(const Sender: TObject;
  const ARemoteIdentifier: string; var Password: string);
begin
  Password := 'VCLManagerPassword';
end;

procedure TForm1.btnAutoConnectClick(Sender: TObject);
begin
  ATManagerFMX.AutoConnect();
end;

procedure TForm1.histo(ch: string);
begin
  Memo1.Lines.Insert(0, ch);
end;

procedure TForm1.TetheringAppProfile1AcceptResource(const Sender: TObject;
  const AProfileId: string; const AResource: TCustomRemoteItem;
  var AcceptResource: Boolean);
begin
  AcceptResource := AResource.Hint = 'ToucanImg';
end;

procedure TForm1.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  if (AResource.Hint = 'ToucanImg') and
    (AResource.ResType = TRemoteResourcetype.Stream) then
  begin
    var
    f := tpath.combine(tpath.gettemppath, 'test.png');
    var
    s := tfilestream.Create(f, fmCreate);
    try
      s.CopyFrom(AResource.Value.AsStream, 0);
    finally
      freeandnil(s);
    end;
    ImageViewer1.Bitmap.LoadFromFile(f);
  end;
end;

procedure TForm1.TetheringAppProfile1Resources0ResourceReceived
  (const Sender: TObject; const AResource: TRemoteResource);
begin
  histo('Reçu : ' + AResource.Value.AsString);
end;

end.
