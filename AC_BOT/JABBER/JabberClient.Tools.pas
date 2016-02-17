{*******************************************************}
{                                                       }
{       Jabber Tools                                    }
{                                                       }
{  	    Copyright (c) 2008-2009 Dmitriy Kuzan           }
{                                                       }
{*******************************************************}
unit JabberClient.Tools;

interface

Uses janXMLparser2, SysUtils, Dialogs, IcsMD5,
     KDSocket.Utilites,
     JabberClient.Types,
     _MyFunctions.Strings;

 // Конвертирование
 function Show_Str2Type(ShowState : String) : TShow;
 function Show_Type2Str(ShowState : TShow)  : String;
 function SubscriptionStates_Str2Type(State : String) : TSubscriptionStates;
 function SubscriptionStates_Type2Str(State : TSubscriptionStates) : String;

 // Получить Namespace
 Function GetNS(Node : TjanXMLNode2): String;
 // Компрессия пробелов
 Function CompressSpaces(Str : String): String;
 function GetRandomHexBytes(BytesCount : Integer) : string;
 function ExtractFromKeys(Keys, KeyName: String; var KeyValue : String) : Boolean;
 // Пакеты для авторизации
 function Packet_Welcome(ServerName : String) : UTF8String;
 function Packet_Initiation : UTF8String;
 function Packet_ResponseChallengeAuth(User, Host, Password, nonce, cnonce : String) : string;
 function Packet_ResponseChallengeOk : string;
 function Packet_Bind(Resouce : String)  : UTF8String;
 function Packet_JIDOk: UTF8String;
 // Стутусы
 function Packet_Show(Show : TShow): UTF8String;
 function Packet_Status(Status : String): UTF8String;
 function Packet_Priority(Priority : Byte): UTF8String;
 // Пакеты для основной работы
 function Packet_Subscribe(JIDTo: WideString): UTF8String;
 function Packet_Unsubscribe(JIDTo: WideString): UTF8String;
 function Packet_SendMessage(JIDTo, JIDFrom: WideString; Body : String): UTF8String;
 function Packet_SendSubscribe(JIDTo, JIDFrom : WideString): UTF8String;
 function Packet_SendUnsubscribed(JIDTo, JIDFrom : WideString): UTF8String;
 // XEP
 function Packet_XEP_Service_Discovery(JIDTo, JIDFrom, JIDID : WideString): UTF8String;
 function Packet_XEP_Jabber_IQ_Version(JIDTo, JIDFrom, JIDID : WideString;
                                       Client, Version : WideString): UTF8String;
 // Управление ростером
 function Packet_GetRosterList(JIDFrom : WideString): UTF8String;
 function Packet_Roster_AddOrUpdate(JIDUpdate: WideString ; RosterInfo : TRosterInfo;
                                    JIDFrom : WideString): UTF8String;
 function Packet_Roster_Delete(JIDDelete, JIDFrom : WideString): UTF8String;


implementation

  function Show_Str2Type(ShowState : String) : TShow;
  var
   I : Integer;
  begin
   Result := tsUNKNOWN;
   for I := 0 to MaxShow do
   begin
       if AnsiCompareStr(ShowState, arrShowTypeS[i]) = 0  then
       begin
          Result := arrShowType[i];
          Exit;
       end;
   end;
  end;

  function Show_Type2Str(ShowState : TShow)  : String;
  var
   I : Integer;
  begin
   Result := '';;
   for I := 0 to MaxShow do
   begin
       if ShowState = arrShowType[i] then
       begin
          Result := arrShowTypeCaption[i];
          Exit;
       end;
   end;
  end;

  function SubscriptionStates_Str2Type(State : String) : TSubscriptionStates;
  var
   I : Integer;
  begin
   Result := tssNone;
   for I := 0 to MaxSubscriptionStates do
   begin
       if AnsiCompareStr(State, arrSubscriptionStatesS[i]) = 0  then
       begin
          Result := arrSubscriptionStates[i];
          Exit;
       end;
   end;
  end;

  function SubscriptionStates_Type2Str(State : TSubscriptionStates) : String;
  var
   I : Integer;
  begin
   Result := arrSubscriptionStatesS[0];
   for I := 0 to MaxSubscriptionStates do
   begin
       if State = arrSubscriptionStates[i] then
       begin
          Result := arrSubscriptionStatesS[i];
          Exit;
       end;
   end;
  end;


  Function GetNS(Node : TjanXMLNode2): String;
  begin
    Result := Node.attribute['xmlns'];
  end;

  Function CompressSpaces(Str : String): String;
  var
   c, i: integer;
   stt, st1: string;
  begin
    for i := 1 to Length(Str) do
    begin
      stt := copy(Str, i, 1);
      if (stt = ' ') and (c >= 1) then
      begin
        st1 := st1;
        c := c + 1;
      end
      else if (stt = ' ') and (c = 0) then
      begin
        c := c + 1;
        st1 := st1 + stt;
      end
      else if (stt <> ' ') then
      begin
        c := 0;
        st1 := st1 + stt;
      end
    end;
    Result := st1;
  end;

 function GetRandomHexBytes(BytesCount : Integer) : string;
 Const
   Bit16 = '0123456789abcdef';
 var
   I : Integer;
 begin
   Result := '';
   for I := 0 to BytesCount do
   begin
       Result := Result + Bit16[Random(15)+1] ;
   end;
 end;

 function ExtractFromKeys(Keys, KeyName: String; var KeyValue : String) : Boolean;
 var
   ArrValue  : TSepRec;
   I         : Integer;
   Str       : string;
      Function GetValue(Str : string) : string;
      var
        Posit, I : Integer;
      begin
        Posit := Pos('=' , Str);
        if Posit > 0 then
        begin
           Result := '';
           for I := Posit + 1 to Length(Str) do
               Result := Result + Str[i];
           // Убираем двойные кавычки
           if Pos('"',Result) = 1 then
              Result := Copy(Result, 2, Length(Result)-2)
        end
        else
           Result := '';
      end;
 begin
   Result := False;
   ArrValue := GetSeparatorRec(Keys, ',');
   for I := 1 to ArrValue.Max do
   begin
       Str := Trim(ArrValue.Rec[I]);
       if Pos(KeyName, Str) > 0 then
       begin
          Result   := True;
          KeyValue := GetValue(Str);
          Exit;
       end;
   end;
 end;

 function Packet_Welcome(ServerName : String) : UTF8String;
 begin
   Result := UTF8Encode(Format(
      '<?xml version=''1.0'' encoding=''UTF-8''?> '+
      '<stream:stream '+
      'to=''%S'' '+
      'xmlns=''jabber:client'' '+
      'xmlns:stream=''http://etherx.jabber.org/streams'' '+
      'xml:l=''ru'' '+
      'version=''1.0''>',[ServerName]));
 end;

 function Packet_Initiation : UTF8String;
 begin
   Result := UTF8Encode(
      '<auth xmlns=''urn:ietf:params:xml:ns:xmpp-sasl'' mechanism=''DIGEST-MD5''/>'
             );
 end;
        
function GenResponse(UserName, realm, digest_uri, Pass, nonce, cnonce : String) : string;
const
  nc         = '00000001';
  gop        = 'auth';
var
  A2, HA1, HA2,
  sJID : String;
  Razdel    : Byte;
  Context   : TMD5Context;
  DigestJID : TMD5Digest;
  DigestHA1 : TMD5Digest;
  DigestHA2 : TMD5Digest;
  DigestResponse : TMD5Digest;
begin
  Razdel := Ord(':');
  // ВЫЧИСЛЯЕМ А1 по формуле RFC 2831
  //  A1 = { H( { username-value, ":", realm-value, ":", passwd } ),
  //           ":", nonce-value, ":", cnonce-value, ":", authzid-value }
  sJID  := format('%S:%S:%S', [username, realm, Pass]);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@sJID[1])  , Length(sJID));
  MD5Final(DigestJID, Context);

  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@DigestJID),SizeOf(TMD5Digest));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@nonce[1])  , Length(nonce));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@cnonce[1])  , Length(cnonce));
  MD5Final(DigestHA1, Context);

  // ВЫЧИСЛЯЕМ А2 по формуле RFC 2831
  //  A2       = { "AUTHENTICATE:", digest-uri-value }
  A2   := format('AUTHENTICATE:%S', [digest_uri]);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@A2[1])  , Length(A2));
  MD5Final(DigestHA2, Context);

  // ВЫЧИСЛЯЕМ RESPONSE по формуле RFC 2831
  //  HEX( KD ( HEX(H(A1)),
  //                 { nonce-value, ":" nc-value, ":",
  //                   cnonce-value, ":", qop-value, ":", HEX(H(A2)) }))
  HA1 := LowerCase( PacketToHex(@DigestHA1, SizeOf(TMD5Digest)));
  HA2 := LowerCase( PacketToHex(@DigestHA2, SizeOf(TMD5Digest)));
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@HA1[1]),Length(HA1));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@nonce[1])  , Length(nonce));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@nc[1])  , Length(nc));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@cnonce[1])  , Length(cnonce));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@gop[1])  , Length(gop));
  MD5UpdateBuffer(Context, @Razdel , SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@HA2[1]),Length(HA2));
  MD5Final(DigestResponse, Context);
  Result := LowerCase( PacketToHex(@DigestResponse, SizeOf(TMD5Digest)) )
 end;

 function Packet_ResponseChallengeAuth(User, Host, Password, nonce, cnonce : String) : string;
 var
  Str, Response : string;
 begin
  {
  Где
    username   - имя JIDNode
    realm      - хост машины
    nonce      - уникальная строка присланная нам ранее сервером
    cnonce     - 64 бит уникальный отпечаток
    digest-uri - Название службы к которому клинт хотел бы подключится, образуется из хоста и типа протокола
    ...
    response   - пароль (Комбинация из 32 цифр HEX -  вычисляется)
  }

  // Вычиляем пароль
  Response := GenResponse(User, Host,'xmpp/' + host, Password, nonce, cnonce);

  Str := UTF8Encode(
    Format('username="%s",realm="%s",nonce="%s",cnonce="%s",nc=00000001,'+
           'qop=auth,digest-uri="xmpp/%s",charset=utf-8,response=%s',
             [User, Host, nonce, cnonce, host, Response])
                   );

  Str := EncodeBase64(Str);
  Result := Format(
             '<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''>%S</response>',
             [Str]);
 end;

 function Packet_ResponseChallengeOk : string;
 begin
   Result :=
     '<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''/>';
 end;


 function Packet_Bind(Resouce : String)  : UTF8String;
 begin
  Result := UTF8Encode(CompressSpaces(Format(
            '<iq type=''set'' id=''bund_2''>                    ' +
            '  <bind xmlns=''urn:ietf:params:xml:ns:xmpp-bind''>' +
            '        <resource>%S</resource>                    ' +
            '  </bind>                                          ' +
            '</iq>                                              ',
            [Resouce])));
 end;

 function Packet_JIDOk: UTF8String;
 begin
  Result := UTF8Encode(Format(
            '<iq type=''set'' id=''bind_2''>' +
            '<session xmlns=''urn:ietf:params:xml:ns:xmpp-session''/></iq>',
            []));
 end;

 function Packet_Show(Show : TShow): UTF8String;
 var
  S: string;
 begin
  case Show of
   tsONLINE : S := '';
   tsDND  : S := 'dnd';
   tsXA   : S := 'xa';
   tsAWAY : S := 'away';
   tsCHAT : S := 'chat';
  end;
  Result := UTF8Encode(Format(
            '<presence><show>%s</show></presence>',
            [S]
            ));
 end;

 function Packet_Priority(Priority : Byte): UTF8String;
 begin
  Result := UTF8Encode(Format(
            '<presence><priority>%D</priority></presence>',
            [Priority]
            ));
 end;

 function Packet_Status(Status : String): UTF8String;
 begin
  Result := UTF8Encode(Format(
            '<presence><status>%S</status></presence>',
            [Status]
            ));
 end;

 function Packet_Subscribe(JIDTo: WideString): UTF8String;
 begin
  Result := UTF8Encode(Format(
            '<presence to=''%s'' type=''subscribed''/>',
            [JIDTo]));
 end;


 function Packet_Unsubscribe(JIDTo: WideString): UTF8String;
 begin
  Result := UTF8Encode(Format(
            '<presence to=''%s'' type=''unsubscribed''/>',
            [JIDTo]));
 end;

 function Packet_SendMessage(JIDTo, JIDFrom: WideString; Body : String): UTF8String;
 begin
 {
  Поскольку символы "<" и ">" используются для обозначения самих тегов, то
  их вставка в текст не приводит к реальному
  отображению самих символов в тексте (за исключением случая, когда вставлен
  символ ">", но никакой тег не был открыт).
  У этих символов есть специальное обозначение в html: "<" - это "&lt;", а ">" -
  это "&gt;". Таким образом, чтобы написать "2 >
  1", нужно написать "2 &gt; 1". То же самое касается и знака "&" - о
  н вставляется с помощью "&amp;".
  Также рекомендуется заменять и кавычки (хотя в большинстве случаев
  они хорошо распознаются и без этого).
  Эквивалент двойных кавычек - "&quot;"
  }
  Body   := StringReplace(Body,'<', '&lt;',[rfIgnoreCase]);
  Body   := StringReplace(Body,'>', '&gt;',[rfIgnoreCase]);
  Body   := StringReplace(Body,'&', '&amp;',[rfIgnoreCase]);
  Body   := StringReplace(Body,'"', '&quot;',[rfIgnoreCase]);
  Result := UTF8Encode(Format(
            '<message type="chat" to="%S" id="ID_1" from="%S"><body>%S</body></message>',
            [JIDTo, JIDFrom, Body]));
 end;

 function Packet_SendSubscribe(JIDTo, JIDFrom : WideString): UTF8String;
 begin
  Result := UTF8Encode(Format(
           '<presence to="%S" type="subscribe" from="%S"/>' +
           '<presence from="%S" to="%S">' +
           '<priority>0</priority>' +
           '<c xmlns="http://jabber.org/protocol/caps"/>'+
           '</presence>',
            [JIDTo, JIDFrom, JIDFrom, JIDTo]));
 end;

 function Packet_SendUnsubscribed(JIDTo, JIDFrom : WideString): UTF8String;
 begin
  Result := UTF8Encode(Format(
           '<presence to="%S" type="unsubscribed" from="%S"/>' +
           '<presence type="unavailable" from="%S" to="%S"/>',
            [JIDTo, JIDFrom, JIDFrom, JIDTo]));
 end;

 function Packet_XEP_Jabber_IQ_Version(JIDTo, JIDFrom, JIDID : WideString;
                                       Client, Version : WideString): UTF8String;
 begin
  Result := UTF8Encode(CompressSpaces(Format(
            '<iq                                   ' +
            '    type=''result''                   ' +
            '    to=''%S''                         ' +
            '    from=''%S''                       '+
            '    id=''%S''>                        ' +
            '  <query xmlns=''jabber:iq:version''> ' +
            '    <name>%S</name>                   ' +
            '    <version>%S</version>             ' +
            '  </query>                            ' +
            '</iq>                                 ' ,
            [JIDTo, JIDFrom, JIDID, Client, Version])));
 end;

 function Packet_XEP_Service_Discovery(JIDTo, JIDFrom, JIDID : WideString): UTF8String;
 begin
  // Поддержка только пока следующих расширений
  //  XEP-0092: Software Version (jabber_iq_version)
  Result := UTF8Encode(CompressSpaces(Format(
            '<iq                                                            ' +
            '    type=''result''                                            ' +
            '    to=''%S''                                                  ' +
            '    from=''%S''                                                ' +
            '    id=''%S''>                                                 ' +
            '  <query xmlns=''http://jabber.org/protocol/disco#info''>      ' +
            '    <feature var=''jabber:iq:version''/>                       ' +
            '  </query>                                                     ' +
            '</iq>                                                          ' ,
            [JIDTo, JIDFrom, JIDID])));
 end;

 function Packet_GetRosterList(JIDFrom : WideString): UTF8String;
 begin
  Result := UTF8Encode(CompressSpaces(Format(
            '<iq from=''%S'' type=''get'' id=''roster_1''>'+
            '   <query xmlns=''jabber:iq:roster''/>       '+
            '</iq>                                        ',
            [JIDFrom])));
 end;

 function Packet_Roster_AddOrUpdate(JIDUpdate: WideString ; RosterInfo : TRosterInfo;
                                    JIDFrom : WideString): UTF8String;
 var
  Script : string;
 begin
  Script := '<iq from=''%S'' type=''set'' id=''RosterUpdate''> '+
            '  <query xmlns=''jabber:iq:roster''>          '+
            '    <item jid=''%S''                          '+
            '          name=''%S''                         '+
            '          subscription=''%S''>                '+
            '    </item>                                   '+
            '  </query>                                    '+
            '</iq>                                         ';

  Result := UTF8Encode(CompressSpaces(Format(Script,
            [JIDFrom,
            JIDUpdate,
            RosterInfo.Name,
            SubscriptionStates_Type2Str(RosterInfo.SubscriptionStates)
            ])));
  end;

 function Packet_Roster_Delete(JIDDelete, JIDFrom : WideString): UTF8String;
 var
  Script : string;
 begin
  Script := '<iq from=''%S'' type=''set'' id=''RosterDelete''> ' +
            ' <query xmlns=''jabber:iq:roster''>                  ' +
            '   <item jid=''%S'' subscription=''remove''/>        ' +
            ' </query>                                            ' +
            '</iq>                                                ';
  Result := UTF8Encode(CompressSpaces(Format(Script,
            [JIDFrom, JIDDelete])));
 end;

end.


