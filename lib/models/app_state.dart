import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:chatpot_app/models/model_entities.dart';
import 'package:chatpot_app/apis/api_entities.dart';
import 'package:chatpot_app/storage/translation_cache_accessor.dart';

delaySec(int sec) => Future.delayed(Duration(milliseconds: sec * 1000));

enum AppInitState {
  LOGGED_IN, NEWCOMER
}

class AppState extends Model {
  List<Room> _recentRooms;
  List<Room> _crowdedRooms;
  List<MyRoom> _myRooms;
  Member _member;
  bool _loading;

  MyRoom _currentRoom;

  AppState() {
    _member = null;
    _loading = true;
    _myRooms = <MyRoom>[];

    _recentRooms = <Room>[];
    _crowdedRooms = <Room>[];
  }

  Member get member => _member;
  bool get loading => _loading;
  List<Room> get recentRooms => _recentRooms;
  List<Room> get crowdedRooms => _crowdedRooms;

  MyRoom get currentRoom => _currentRoom;
  List<MyRoom> get myRooms => _myRooms;

  List<Message> get messages {
    if (_currentRoom == null) return [];
    return _currentRoom.messages.messages;
  }

  Future<AppInitState> tryAutoLogin() async {
    _loading = true;
    notifyListeners();

    var accesor = authAccessor();
    var token = await accesor.getToken();
    if (token == null) {
      _loading = false;
      notifyListeners();
      return AppInitState.NEWCOMER;
    }

    var member = await memberApi().fetchMy(token);
    _member = member;
    
    _loading = false;
    notifyListeners();
    return AppInitState.LOGGED_IN;
  }

  Future<EmailLoginResp> tryEmailLogin({
    @required String email,
    @required String password
  }) async {
    try {
      _loading = true;
      notifyListeners();

      var resp = await authApi().requestEmailAuth(
        email: email,
        password: password
      );

      if (resp.activated == false) {
        _loading = false;
        notifyListeners();

        return EmailLoginResp(
          memberToken: resp.memberToken,
          activated: resp.activated
        );
      }

      // store credentials
      await authAccessor().setToken(resp.memberToken);
      await authAccessor().setPassword(resp.passphrase);
      await authAccessor().setSessionKey(resp.sessionKey);

      var member = await memberApi().fetchMy(resp.memberToken);
      _member = member;

      _loading = false;
      notifyListeners();

      var ret = EmailLoginResp(
        memberToken: resp.memberToken,
        activated: resp.activated
      );
      return ret;

    } catch (err) {
      _loading = false;
      notifyListeners();
      throw err;
    }
  }

  Future<void> registerDevice() async {
    _loading = true;
    notifyListeners();

    String deviceToken = await pushService().accquireDeviceToken();

    await messageApi().requestRegister(
      memberToken: _member.token,
      deviceToken: deviceToken
    );

    _loading = false;
    notifyListeners();
  }

  Future<void> simpleSignup({
    @required String gender,
    @required String region,
    @required String language
  }) async {
    _loading = true;
    notifyListeners();

    var joinResp = await authApi().requestSimpleJoin(
      gender: gender,
      region: region,
      language: language
    );

    var authResp = await authApi().requestAuth(
      loginId: joinResp.token,
      password: joinResp.passphrase
    );

    await authAccessor().setToken(joinResp.token);
    await authAccessor().setPassword(joinResp.passphrase);
    await authAccessor().setSessionKey(authResp.sessionKey);

    var member = await memberApi().fetchMy(joinResp.token);
    _member = member;
    _loading = false;
    notifyListeners();
  }

  Future<void> signout() async {
    _loading = true;
    notifyListeners();

    authAccessor().setToken(null);
    authAccessor().setPassword(null);
    authAccessor().setSessionKey(null);

    _member = null;
    _loading = false;
    notifyListeners();
  }

  Future<void> fetchHomeSceneRooms() async {
    _loading = true;
    notifyListeners();
    var featuredResp = await roomApi().requestFeaturedRooms();
    _recentRooms = featuredResp.recent;
    _crowdedRooms = featuredResp.crowded;
    _loading = false;
    notifyListeners();
  }

  Future<JoinRoomResp> joinToRoom(String roomToken) async {
    _loading = true;
    notifyListeners();

    try {
      await roomApi().requestRoomJoin(
        memberToken: _member.token,
        roomToken: roomToken);
    } catch (err) {
      if (err is ApiFailureError) {
        _loading = false;
        notifyListeners();
        return JoinRoomResp(success: false, cause: err.code);
      }
    }

    _loading = false;
    notifyListeners();
    return JoinRoomResp(success: true);
  }

  void outFromRoom() {
    _currentRoom.messages.clearOffset();
    _currentRoom = null;
  }

  Future<void> leaveFromRoom(String roomToken) async {
    _loading = true;
    notifyListeners();

    await roomApi().requestRoomLeave(
      roomToken: roomToken,
      memberToken: _member.token
    );
    _myRooms.removeWhere((var r) => r.roomToken == roomToken);
    _loading = false;
    notifyListeners();
  }

  Future<void> fetchMyRooms() async {
    _loading = true;
    notifyListeners();

    var resp = await roomApi().requestMyRooms(memberToken: _member.token);
    _myRooms = resp;
    _loading = false;
    notifyListeners();
  }

  Future<String> createNewRoom({
    @required String roomTitle,
    @required int maxAttendee
  }) async {
    _loading = true;
    notifyListeners();

    try {
      String roomToken = await roomApi().requestCreateRoom(
        memberToken: _member.token,
        title: roomTitle,
        maxAttendee: maxAttendee
      );

      List<MyRoom> myRooms = await roomApi().requestMyRooms(
        memberToken: _member.token
      );
      _myRooms = myRooms;
      return roomToken;

    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> selectRoom({
    @required MyRoom room
  }) async {
    _currentRoom = room;
  }

  Future<void> fetchMoreMessages({
    @required String roomToken
  }) async {
    if (_currentRoom == null) return;

    _loading = true;
    notifyListeners();

    var resp = await messageApi().requestMessages(
      roomToken: roomToken,
      offset: _currentRoom.messages.offset,
      size: 20
    );
    _currentRoom.messages.appendMesasges(resp.messages);

    _loading = false;
    notifyListeners();
  }

  Future<void> fetchMessagesWhenResume({
    @required String roomToken
  }) async {
    if (_currentRoom == null) return;
    _loading = true;
    notifyListeners();

    var resp = await messageApi().requestMessages(
      roomToken: roomToken,
      offset: 0,
      size: 20
    );

    if (_currentRoom != null) {
      _currentRoom.messages.clearOffset();
      _currentRoom.messages.clearMessages();
      _currentRoom.messages.appendMesasges(resp.messages);
      _currentRoom.messages.dumpQueuedMessagesToMessage();
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> addSingleMessage({
    @required Message msg
  }) async {
    var rooms = _myRooms.where((r) =>
      r.roomToken == msg.to.token && msg.to.type == MessageTarget.ROOM);
    if (rooms.length == 0) return;

    MyRoom myRoom = rooms.toList()[0];
    if (_currentRoom != null && myRoom.roomToken == _currentRoom.roomToken) {
      _currentRoom.messages.appendSingleMessage(msg);
      _currentRoom.lastMessage = msg;
    } else {
      myRoom.lastMessage = msg;
      myRoom.messages.increaseNotViewed();
    }
    notifyListeners();
  }

  Future<void> addSingleMessageFromPush({
    @required Message msg
  }) async {
    var rooms = _myRooms.where((r) =>
      r.roomToken == msg.to.token && msg.to.type == MessageTarget.ROOM);
    if (rooms.length == 0) return;

    MyRoom myRoom = rooms.toList()[0];
    if (_currentRoom != null && myRoom.roomToken == _currentRoom.roomToken) {
      _currentRoom.messages.appendSingleMessage(msg);
      _currentRoom.lastMessage = msg;

      if (msg.messageType == MessageType.TEXT &&
            msg.from.token != _member.token &&
            msg.from.language != _member.language) {

        TranslateParam param = TranslateParam(
          key: msg.messageId,
          message: msg.getTextContent(),
          from: msg.from.language
        );
        var translated = await translateApi().requestTranslateMessages(
          queries: [ param ],
          toLocale: _member.language
        );

        if (translated.length > 0) {
          msg.translated = translated[0].translated;
          translationCacheAccessor().cacheTranslations(
            roomToken: _currentRoom.roomToken,
            translated: [Translated(
              key: msg.messageId,
              translated: translated[0].translated
            )]
          );
        }
      }

    } else {
      myRoom.lastMessage = msg;
      myRoom.messages.increaseNotViewed();
    }
    notifyListeners();
  }

  Future<void> publishMessage({
    @required MessageType type,
    @required dynamic content,
    String previousMessageId
  }) async {
    if (_currentRoom == null) return;
    var publishResult = await messageApi().requestPublishToRoom(
      roomToken: _currentRoom.roomToken,
      memberToken: _member.token,
      type: type,
      content: content
    );
    String messageId = publishResult.messageId;

    if (previousMessageId != null) {
      _currentRoom.messages.changeMessageId(previousMessageId, messageId);

    } else {
      Message newMsg = Message();
      var to = MessageTo();
      to.type = MessageTarget.ROOM;
      to.token = _currentRoom.roomToken;

      newMsg.messageId = messageId;
      newMsg.messageType = type;
      newMsg.content = content;
      newMsg.sentTime = DateTime.now();
      newMsg.from = _member;
      newMsg.to = to;
      newMsg.changeToSending();

      _currentRoom.messages.appendSingleMessage(newMsg);
    }

    notifyListeners();
  }

  Future<ImageContent> uploadImage({
    @required File image,
    @required String tempMessageId
  }) async {
    Message msg = Message();
    
    MessageTo to = MessageTo();
    to.type = MessageTarget.ROOM;
    to.token = _currentRoom.roomToken;
    msg.to = to;
    msg.changeToSending();

    msg.messageId = tempMessageId;
    msg.messageType = MessageType.IMAGE;
    msg.from = member;
    msg.changeToLocalImage(image.path);
    msg.sentTime = DateTime.now();

    currentRoom.messages.appendQueuedMessage(msg);
    if (currentRoom == null) return null;
    notifyListeners();

    var resp = await assetApi().uploadImage(image,
      callback: (prog) {
        msg.changeUploadProgress(prog);
        notifyListeners();
      }
    );

    msg.changeToRemoteImage(
      imageUrl: resp.orig,
      thumbUrl: resp.thumbnail
    );

    if (currentRoom == null) return null;
    currentRoom.messages.dumpQueuedMessagesToMessage();

    notifyListeners();
    ImageContent content = ImageContent(
      imageUrl: resp.orig,
      thumbnailUrl: resp.thumbnail
    );
    return content;
  }

  Future<void> translatePublicRooms() async {
    Map<String, TranslateParam> paramMap = Map();
    _crowdedRooms.forEach((r) {
      if (r.owner.language == _member.language) return;
      paramMap[r.roomToken] = TranslateParam(
        from: r.owner.language,
        key: r.roomToken,
        message: r.title);
    });
    _recentRooms.forEach((r) {
      if (r.owner.language == _member.language) return;
      paramMap[r.roomToken] = TranslateParam(
        from: r.owner.language,
        key: r.roomToken,
        message: r.title);
    });
    
    List<TranslateParam> queries =
      paramMap.keys.map((k) => paramMap[k]).toList();

    List<String> cacheQueries = queries.map((q) => q.key).toList();
    List<Translated> cachedTranslations = await
      translationCacheAccessor().getCachedRoomTitleTranslations(keys: cacheQueries);

    cachedTranslations.forEach((c) {
      List<Room> foundInCrowd = _crowdedRooms.where((r) => r.roomToken == c.key).toList();
      if (foundInCrowd.length > 0) foundInCrowd[0].titleTranslated = c.translated;

      List<Room> foundInRecent = _recentRooms.where((r) => r.roomToken == c.key).toList();
      if (foundInRecent.length > 0) foundInRecent[0].titleTranslated = c.translated;
    });

    List<TranslateParam> filteredQuery = 
      queries.where((q) =>
         cachedTranslations.where((c) => 
          c.key == q.key).length == 0).toList();

    if (filteredQuery.length > 0) {
      var apiResp = await translateApi().requestTranslateRooms(
        toLocale: _member.language,
        queries: filteredQuery
      );
      
      apiResp.forEach((t) {
        List<Room> foundInCrowd = _crowdedRooms.where((r) => r.roomToken == t.key).toList();
        if (foundInCrowd.length > 0) foundInCrowd[0].titleTranslated = t.translated;

        List<Room> foundInRecent = _recentRooms.where((r) => r.roomToken == t.key).toList();
        if (foundInRecent.length > 0) foundInRecent[0].titleTranslated = t.translated;
      });

      if (apiResp.length > 0) {
        List<Translated> cacheParams = 
        apiResp.map((r) => Translated(
          key: r.key,
          translated: r.translated
        )).toList();
        await translationCacheAccessor().cacheRoomTitleTranslations(translated: cacheParams);
      }
    }
    notifyListeners();
  }

  Future<void> translateMyRooms() async {
    Map<String, TranslateParam> paramMap = Map();
    _myRooms.forEach((r) {
      if (r.owner.language == _member.language) return;
      if (r.titleTranslated != null) return;
      paramMap[r.roomToken] = TranslateParam(
        key: r.roomToken,
        message: r.title,
        from: r.owner.language
      );
    });

    List<TranslateParam> queries =
      paramMap.keys.map((k) => paramMap[k]).toList();

    List<Translated> cachedList =
      await translationCacheAccessor()
        .getCachedRoomTitleTranslations(
          keys: queries.map((q) => q.key).toList());

    cachedList.forEach((c) {
      List<MyRoom> founds = _myRooms.where((r) => r.roomToken == c.key).toList();
      if (founds.length > 0) {
        founds[0].titleTranslated = c.translated;
      }
      print("MY_ROOM_TITLE TRANSLATION CACHE USED");
    });

    List<TranslateParam> filteredQuery = 
      queries.where((q) =>
         cachedList.where((c) => 
          c.key == q.key).length == 0).toList();

    if (filteredQuery.length > 0) {
      var apiResp = await translateApi().requestTranslateRooms(
        toLocale: _member.language,
        queries: filteredQuery
      );

      // cache translation response.
      if (apiResp.length > 0) {
        apiResp.forEach((t) {
          List<MyRoom> founds = _myRooms.where((r) => r.roomToken == t.key).toList();
          if (founds.length > 0) founds[0].titleTranslated = t.translated;
          print("MY_ROOM_TITLE TRANSLATION API RESPONSE USED");
        });
        List<Translated> cacheParams = 
          apiResp.map((r) => Translated(
            key: r.key,
            translated: r.translated
          )).toList();
        await translationCacheAccessor().cacheRoomTitleTranslations(translated: cacheParams);
      }
    }    

    notifyListeners();
  }

  Future<void> translateMessages() async {
    if (_currentRoom == null) return;

    List<Message> translationTargets =
      _currentRoom.messages.messages.where((m) {
        if (m.from == null) return false;
        if (m.from.language == _member.language) return false;
        if (m.messageType != MessageType.TEXT) return false;
        return true;
      }).toList();

    List<Translated> cachedTranslations =
      await translationCacheAccessor().getCachedTranslations(
        roomToken: _currentRoom.roomToken,
        keys: translationTargets.map((m) => m.messageId).toList()
      );

    List<TranslateParam> queries =
      translationTargets
      .where((m) =>
        cachedTranslations.where((t) => 
          t.key == m.messageId).length == 0
      )
      .map((m) => TranslateParam(
        from: m.from.language,
        key: m.messageId,
        message: m.getTextContent()
      ))
      .toList();

    if (queries.length > 0) {
      var resp = await translateApi().requestTranslateMessages(
        queries: queries,
        toLocale: _member.language
      );

      if (_currentRoom == null) return;

      resp.forEach((t) {
        print("API_CALL_TRANSLATED_MESSAGE: ${t.translated}");
        Message m = _currentRoom.messages.findMessage(t.key);
        if (m != null) m.translated = t.translated;
      });

      List<Translated> cacheElems = 
        resp.map<Translated>((t) =>
          Translated(
            key: t.key,
            translated: t.translated
          )
        ).toList();

      if (_currentRoom == null) return;

      translationCacheAccessor().cacheTranslations(
        roomToken: _currentRoom.roomToken,
        translated: cacheElems);
    } 

    cachedTranslations.forEach((t) {
      print("CACHED_TRANSLATED_MESSAGE: ${t.translated}");
      Message msg = _currentRoom.messages.findMessage(t.key);
      if (msg != null) msg.translated = t.translated;
    });

    notifyListeners();
  }

  Future<void> changePassword({
    @required String currentPassword,
    @required String newPassword
  }) async {
    _loading = true;
    notifyListeners();

    try {
      var resp = await memberApi().changePassword(
        memberToken: this.member.token,
        currentPassword: currentPassword,
        newPassword: newPassword
      );

      await authAccessor().setPassword(resp.passphrase);
      _loading = false;
      notifyListeners();

    } catch (err) {
      _loading = false;
      notifyListeners();
      throw err;  
    }
  }

  Future<void> blockMember({
    @required String targetMemberToken,
    String note
  }) async {
    _loading = true;
    notifyListeners();

    try {
      await blockAccessor().block(
        memberToken: targetMemberToken,
        note: note
      );
    } catch (err) {
      throw err;
      
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}