program AC_BV;

uses
  Forms,
  Main_u in 'Main_u.pas' {wndMain},
  KDSocket.Types in 'JABBER\KDSocket.Types.pas',
  KDSocket.Utilites in 'JABBER\KDSocket.Utilites.pas',
  JabberClient in 'JABBER\JabberClient.pas',
  JabberClient.Types in 'JABBER\JabberClient.Types.pas',
  JabberClient.Tools in 'JABBER\JabberClient.Tools.pas',
  JabberClient.Rosters in 'JABBER\JabberClient.Rosters.pas',
  janXMLparser2 in 'JABBER\janXMLparser2.pas',
  janXPathTokenizer in 'JABBER\janXPathTokenizer.pas',
  janStrings in 'JABBER\janStrings.pas',
  KDSocket.Proxy in 'JABBER\KDSocket.Proxy.pas',
  KDSocket.Custom in 'JABBER\KDSocket.Custom.pas',
  KDSocket.Buffer in 'JABBER\KDSocket.Buffer.pas',
  KDSocket.HTTP in 'JABBER\KDSocket.HTTP.pas',
  KDSocket.Servers in 'JABBER\KDSocket.Servers.pas',
  IcsMD5 in 'JABBER\IcsMD5.pas',
  _MyFunctions.Strings in 'JABBER\_MyFunctions.Strings.pas',
  ICQClient in 'ICQ\ICQClient.pas',
  ICQDb in 'ICQ\ICQDb.pas',
  ICQDirect2 in 'ICQ\ICQDirect2.pas',
  ICQLang in 'ICQ\ICQLang.pas',
  ICQSock in 'ICQ\ICQSock.pas',
  ICQWorks in 'ICQ\ICQWorks.pas',
  uMD5Hash in 'ICQ\uMD5Hash.pas',
  Add_u in 'Add_u.pas' {dlgAdd},
  About_u in 'About_u.pas' {dlgAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '[AC]';
  Application.CreateForm(TwndMain, wndMain);
  Application.Run;
end.
