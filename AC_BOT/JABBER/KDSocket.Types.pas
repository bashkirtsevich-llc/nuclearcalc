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


  // ��� ����������
  TProxyType_ = (P_NONE, P_HTTPS, P_HTTP);

resourcestring
  ERR_SOCKET_SEND    = '���������� �������� ���������� �� ������';
  ERR_SOCKET_RECV    = '���������� �������� ���������� � ������';
  ERR_SOCKET_CONNECT = '���������� ���������� ���������� ����� ����� � %S:%D';
  ERR_SOCKET_RESOLVE = '���������� �������� IP �����';
  ERR_SOCKET_CREATE  = '���������� ������� �����';
  ERR_HTTP_STATUS    = 'HTTP ������ �������� ������: ';
  ERR_HTTP_OVERSIZE_BUFFER = '������������ ������� HTTP';

implementation

end.
