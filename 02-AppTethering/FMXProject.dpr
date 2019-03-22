program FMXProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMXForm in 'FMXForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
