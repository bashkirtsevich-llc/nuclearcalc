unit KDSocket.Types;

interface

Type
  TErrorType_ = (ERR_SOCKET, ERR_PROTOCOL);

  TOnError = procedure(Sender: TObject; ErrorType: TErrorType_; ErrorMsg: String)
                                                                      of object;
  TOnRecveive = procedure(Sender: TObject; Buffer: Pointer; BufLen: LongWord)
                                                                      of object;
  TOnPacketParse = procedure(Sender: TObject;
                              Host: String;
                              Port: Word;
                              Buffer: Pointer;
                              BufLen: LongWord;
                              Incoming: Boolean) of object;


  // Тип соединений
  TProxyType_ = (P_NONE, P_HTTPS, P_HTTP);

resourcestring
  ERR_SOCKET_SEND    = 'Невозможно отослать информацию по сокету';
  ERR_SOCKET_RECV    = 'Невозможно получить информацию с сокета';
  ERR_SOCKET_CONNECT = 'Невозможно установить соединение через сокет с %S:%D';
  ERR_SOCKET_RESOLVE = 'Невозможно получить IP хоста';
  ERR_SOCKET_CREATE  = 'Невозможно создать сокет';
  ERR_HTTP_STATUS    = 'HTTP вернул неверный статус: ';
  ERR_HTTP_OVERSIZE_BUFFER = 'Переполнение буффера HTTP';

implementation

end.
