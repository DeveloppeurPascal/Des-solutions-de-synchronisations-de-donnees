unit VCLForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Tether.Manager, System.Tether.AppProfile;

type
  TForm2 = class(TForm)
    ATManagerVCL: TTetheringManager;
    Panel1: TPanel;
    Memo1: TMemo;
    TetheringAppProfile1: TTetheringAppProfile;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure ATManagerVCLPairedFromLocal(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure histo(ch: string);
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ATManagerVCLPairedFromLocal(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
  histo('Connection de ' + AManagerInfo.ManagerText + ' ' +
    AManagerInfo.ManagerName + ' ' + AManagerInfo.ManagerIdentifier);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  TetheringAppProfile1.Resources.FindByName('ValeurPartagee').Value :=
    Edit1.Text;
  histo('Nouvelle ValeurPartagee : ' + Edit1.Text);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  s: tfilestream;
begin
  s := tfilestream.Create('../../Delphi-10_3-Rio-mascotte-2162x2485.png',
    fmOpenRead);
  try
    for var i := 0 to TetheringAppProfile1.ConnectedProfiles.Count - 1 do
    begin
      s.Position := 0;
      TetheringAppProfile1.SendStream(TetheringAppProfile1.ConnectedProfiles[i],
        'ToucanImg', s);
      histo('Toucan envoyé à ' + TetheringAppProfile1.ConnectedProfiles[i]
        .ManagerIdentifier);
    end;
  finally
    freeandnil(s);
  end;
end;

procedure TForm2.histo(ch: string);
begin
  Memo1.Lines.Insert(0, ch);
end;

end.
