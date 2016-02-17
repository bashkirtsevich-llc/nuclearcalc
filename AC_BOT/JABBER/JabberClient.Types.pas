unit JabberClient.Types;

interface

Uses Classes;

type
  // Тип проверки на ошибки
  TErrorTypes   = (tetError, tetFailure, tetNoError);
  // состояние компонента
  TJabberStatus = (tjsDisconnect, tjsConnecting, tjsConnect);
  // статус jabberа
  TShow = (tsONLINE, tsDND, tsXA, tsAWAY, tsCHAT, tsUNKNOWN);
  // Подписка
  TSubscriptionStates = (tssNone, tssBoth, tssTo, tssFrom);

  TRosterInfo = record
                Name : String;
                SubscriptionStates : TSubscriptionStates;
                Groups             : TStringList;
               end;
type
  // ---------------------------------------------------------------------------
  // С О Б Ы Т И Я
  // ---------------------------------------------------------------------------
  // Прислано сообщение
  TJabberSentMessage  = procedure(Sender: TObject;
                                 Types : WideString;
                                 From : WideString;
                                 Body : UTF8String)
                                 of object;
  // Информирования  том что нас включили в подписку (авторизовали)
  TJabberSubscribed = procedure(Sender: TObject;
                                 From : WideString)
                                 of object;
  // Запрос авторизации
  TJabberSubscribe = procedure(Sender: TObject;
                                 From : WideString;
                                 var Action : Boolean)
                                 of object;
  // Отзыв авторизации
  TJabberUnsubscribed = procedure(Sender: TObject;
                                 From : WideString;
                                 var Action : Boolean)
                                 of object;
  // Смена
  TJabberUserChangeShow = procedure(Sender: TObject;
                                 JID : WideString;
                                 Show : TShow)
                                 of object;
  // Change Show Status
  TJabberChangeShow = procedure(Sender: TObject;
                                 JID : WideString;
                                 Show: TShow)
                                 of object;
  // Смена стутусного сообщения
  TJabberChangeStatus = procedure(Sender: TObject;
                                 JID : WideString;
                                 Status : UTF8String)
                                 of object;
  // Общее событие по конкретному JID
  TJabberJIDEvent = procedure(Sender: TObject;
                                 JID : WideString)
                                 of object;



const
  MaxShow               = 3;
  MaxSubscriptionStates = 3;
  // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  arrShowTypeCaption : array [0..MaxShow] of string =
                 ('Занят','Недоступен','Отошел','Готов чатится');

  arrShowTypeS : array [0..MaxShow] of string =
                 ('dnd','xa','away','chat');

  arrShowType : array [0..MaxShow] of TShow =
                 (tsDND, tsXA, tsAWAY, tsCHAT);
  // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  arrSubscriptionStates  : array [0..MaxSubscriptionStates] of TSubscriptionStates =
                 (tssNone, tssBoth, tssTo, tssFrom);

  arrSubscriptionStatesS : array [0..MaxSubscriptionStates] of String =
                 ('none', 'both', 'to', 'from');
  // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
  // XEP-0092: Software Version (jabber_iq_version)
  XEP_Software_Version
                 = 'jabber:iq:version';
  // XEP-0012: Last Activity
  XEP_Last_Activity
                 = 'jabber:iq:last';
  // XEP-0030: Service Discovery
  XEP_Service_Discovery
                 = 'http://jabber.org/protocol/disco#info';

  nsStream        = 'stream';
  nsRoster        = 'jabber:iq:roster';    

  cID             = 'id';
  cFrom           = 'from';
  cTo             = 'to';
  cType           = 'type';
  cJid            = 'jid';
  cName           = 'name';
  cSubscription   = 'subscription';

  vResult         = 'result';
  vError          = 'error';
  vItem           = 'item';
  vGroup          = 'group';
  vSubscribe      = 'subscribe';
  vSubscribed     = 'subscribed';
  vUnsubscribed   = 'unsubscribed';
  vNotAuthorized  = 'not-authorized';
  vGet            = 'get';
  vSet            = 'set';
  vShow           = 'show';
  vStatus         = 'status';
  vUnavailable    = 'unavailable';
  vRemove         = 'remove'; 


  nodeStream      = 'stream:stream';
  nodeFeatures    = 'stream:features';
  nodeError       = 'stream:error';
  nodeFailure     = 'failure';
  nodeChallenge   = 'challenge';
  nodeSuccess     = 'success';
  nodeIQ          = 'iq';
  nodeSession     = 'session';
  nodeBind        = 'bind';
  nodeJID         = 'jid';
  nodeMessage     = 'message';
  nodePresence    = 'presence';
  nodeQuery       = 'query';


resourcestring
  JABBER_ERR_NAMESPACE = 'Неверное пространство имен (stream не найден)';

implementation

end.
