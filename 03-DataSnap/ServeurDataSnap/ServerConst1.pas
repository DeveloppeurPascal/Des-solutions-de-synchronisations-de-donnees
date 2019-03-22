unit ServerConst1;

interface

resourcestring
  sPortInUse = '- Erreur : Le port %s est déjà utilisé';
  sPortSet = '- Port défini sur %s';
  sPortNotSet = '- Le port n'#39'a pas pu être défini.';
  sServerRunning = '- Le serveur est déjà exécuté';
  sStartingServer = '- Démarrage du serveur';
  sServerIsRunning = '- Serveur en cours d'#39'exécution';
  sStoppingServer = '- Arrêt du serveur';
  sServerStopped = '- Serveur arrêté';
  sServerNotRunning = '- Le serveur n'#39'est pas exécuté';
  sInvalidCommand = '- Erreur : Commande non valide';
  sIndyVersion = '- Version Indy : ';
  sActive = '- Actif : ';
  sTCPIPPort = '- Port TCP/IP : ';
  sHTTPPort = '- Port HTTP : ';
  sHTTPSPort = '- Port HTTPS : ';
  sSessionID = '- Nom de cookie de l'#39'ID de session : ';
  sCommands = 'Entrez une commande : '#13#10'   - "start" pour démarrer le serveur'#13#10'   - "stop" pour arrêter le serveur'#13#10'   - "set port -t" pour changer le port TCP/IP par défaut'#13#10'   - "set port -h" pour changer le port HTTP par défaut'#13#10'   - "set port -s" pour changer le port'+
' HTTPS par défaut'#13#10'   - "status" pour obtenir l'#39'état du serveur'#13#10'   - "help" pour afficher les commandes'#13#10'   - "exit" pour fermer l'#39'application';

const
  cArrow = '->';
  cCommandStart = 'start';
  cCommandStop = 'stop';
  cCommandStatus = 'status';
  cCommandHelp = 'help';
  cCommandSetTCPIPPort = 'set port -t';
  cCommandSetHTTPPort = 'set port -h';
  cCommandSetHTTPSPort = 'set port -s';
  cCommandExit = 'exit';

{$SCOPEDENUMS ON}

type
  DSProtocol = (TCPIP, HTTP, HTTPS);

{$SCOPEDENUMS OFF}

implementation

end.


