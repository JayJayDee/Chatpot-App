import 'dart:async';
import 'dart:convert';
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

  Future<void> registerDevice() async {
    _loading = true;
    notifyListeners();

    String deviceToken = await pushService().accquireDeviceToken();
    print("DEVICE_TOKEN = $deviceToken");

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
    print(member);
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
    _myRooms = [];
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

    String roomToken = await roomApi().requestCreateRoom(
      memberToken: _member.token,
      title: roomTitle,
      maxAttendee: maxAttendee
    );

    List<MyRoom> myRooms = await roomApi().requestMyRooms(
      memberToken: _member.token
    );
    _myRooms = myRooms;

    _loading = false;
    notifyListeners();
    return roomToken;
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
    _currentRoom.messages.clearOffset();
    _currentRoom.messages.clearMessages();
    _currentRoom.messages.appendMesasges(resp.messages);
    _currentRoom.messages.dumpQueuedMessagesToMessage();

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

    var apiResp = await translateApi().requestTranslateRooms(
      toLocale: _member.language,
      queries: queries
    );
    
    apiResp.forEach((t) {
      List<Room> foundInCrowd = _crowdedRooms.where((r) => r.roomToken == t.key).toList();
      if (foundInCrowd.length > 0) foundInCrowd[0].titleTranslated = t.translated;

      List<Room> foundInRecent = _recentRooms.where((r) => r.roomToken == t.key).toList();
      if (foundInRecent.length > 0) foundInRecent[0].titleTranslated = t.translated;
    });
    notifyListeners();
  }

  Future<void> translateMyRooms() async {
    Map<String, TranslateParam> paramMap = Map();
    _myRooms.forEach((r) {
      if (r.owner.language == _member.language) return;
      paramMap[r.roomToken] = TranslateParam(
        key: r.roomToken,
        message: r.title,
        from: r.owner.language
      );
    });

    List<TranslateParam> queries =
      paramMap.keys.map((k) => paramMap[k]).toList();
    
    var apiResp = await translateApi().requestTranslateRooms(
      toLocale: _member.language,
      queries: queries
    );

    apiResp.forEach((t) {
      List<MyRoom> founds = _myRooms.where((r) => r.roomToken == t.key).toList();
      if (founds.length > 0) founds[0].titleTranslated = t.translated;
    });
    notifyListeners();
  }

  Future<void> translateMessages() async {
    if (_currentRoom == null) return;

    List<Message> translationTargets =
      _currentRoom.messages.messages.where((m) {
        if (m.from.language == _member.language) return false;
        if (m.messageType != MessageType.TEXT) return false;
        if (_currentRoom.messageTranslated[m.messageId] != null) return false;
        return true;
      }).toList();

    List<TranslateParam> queries =
      translationTargets.map((m) => TranslateParam(
        from: m.from.language,
        key: m.messageId,
        message: m.getTextContent()
      )).toList();

    if (queries.length > 0) {
      var resp = await translateApi().requestTranslateMessages(
        queries: queries,
        toLocale: _member.language
      );
      resp.forEach((t) {
        _currentRoom.messageTranslated[t.key] = t.translated;
      });
    }

    translationTargets.forEach((m) {
      var translated = _currentRoom.messageTranslated[m.messageId];
      if (translated != null) {
        m.translated = translated;
      }
    });
    notifyListeners();
  }
}