unit ServerContainerUnit1;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  IPPeerServer, IPPeerAPI, Datasnap.DSAuth;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Déclarations privées }
  public
  end;

procedure RunDSServer;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  ServerConst1,
  ServerMethodsUnit1;

procedure TServerContainer1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

function BindPort(Aport: Integer): Boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := True;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(APort, nil);
  except
    Result := False;
  end;
end;

function CheckPort(Aport: Integer): Integer;
begin
  if BindPort(Aport) then
    Result := Aport
  else
    Result := 0;
end;

procedure SetPort(const Aserver: TServerContainer1; const APort: string; AProtocol: DSProtocol);
var
  IsPortSet: Boolean;
begin
  IsPortSet := True;
  if not (AServer.DSServer1.Started) then
  begin
    if CheckPort(APort.ToInteger) > 0 then
    begin
      case AProtocol of
        DSProtocol.TCPIP: AServer.DSTCPServerTransport1.Port := APort.ToInteger;
          
      else
        IsPortSet := False
      end;
      if IsPortSet then
        Writeln(Format(sPortSet, [APort]))
      else
        Writeln(Format(sPortNotSet, [APort]));
    end
    else
      Writeln(Format(sPortInUse, [Aport]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StartServer(const AServer: TServerContainer1);
var
  LStart: Boolean;
begin
  LStart := True;
  if not (AServer.DSServer1.Started) then
  begin
    if CheckPort(AServer.DSTCPServerTransport1.Port) <= 0 then
    begin
      Writeln(Format(sPortInUse, [AServer.DSTCPServerTransport1.Port.ToString]));
      LStart := False;
    end;
  end
  else
    Writeln(sServerRunning);

  if LStart then
  begin
    Writeln(sStartingServer);
    AServer.DSServer1.Start;
  end;
  Write(cArrow);
end;

procedure StopServer(const AServer: TServerContainer1);
begin
  if AServer.DSServer1.Started  then
  begin
    Writeln(sStoppingServer);
    AServer.DSServer1.Stop;
    Writeln(sServerStopped);
  end
  else
    Writeln(sServerNotRunning);
  Write(cArrow);
end;

procedure  WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure  WriteStatus(const AServer: TServerContainer1);
begin
  Writeln(sActive + AServer.DSServer1.Started.ToString(TUseBoolStrs.True));
  Writeln(sTCPIPPort + AServer.DSTCPServerTransport1.Port.ToString);
    
  Write(cArrow);
end;

procedure RunDSServer;
var
  LModule: TServerContainer1;
  LResponse: string;
begin
  LModule := TServerContainer1.Create(nil);
    try
      if LModule.DSServer1.Started then
        Writeln(sServerIsRunning);
      WriteCommands;
      while True do
      begin
        Readln(LResponse);
        LResponse := LowerCase(LResponse);
        if sametext(LResponse, cCommandStart) then
          StartServer(LModule)
        else if sametext(LResponse, cCommandStatus) then
          WriteStatus(LModule)
        else if sametext(LResponse, cCommandStop) then
          StopServer(LModule)
        else if LResponse.StartsWith(cCommandSetTCPIPPort) then
          SetPort(LModule, LResponse.Replace(cCommandSetTCPIPPort, '').Trim, DSProtocol.TCPIP)
        else if sametext(LResponse, cCommandHelp) then
          WriteCommands
        else if sametext(LResponse, cCommandExit) then
          if LModule.DSServer1.Started then
          begin
            StopServer(LModule);
            break
          end
          else
            break
        else
        begin
          Writeln(sInvalidCommand);
          Write(cArrow);
        end;
      end;
  finally 
    LModule.Free;
  end;
end;

end.

