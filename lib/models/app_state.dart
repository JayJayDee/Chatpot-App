import 'dart:async';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chatpot_app/entities/member.dart';
import 'package:chatpot_app/entities/room.dart';
import 'package:chatpot_app/entities/message.dart';
import 'package:chatpot_app/factory.dart';
import 'package:chatpot_app/apis/api_errors.dart';
import 'package:chatpot_app/models/model_entities.dart';

delaySec(int sec) => Future.delayed(Duration(milliseconds: sec * 1000));

enum AppInitState {
  LOGGED_IN, NEWCOMER
}

class AppState extends Model {
  List<Room> _publicRooms;
  List<MyRoom> _myRooms;
  Member _member;
  bool _loading;

  MyRoom _currentRoom;

  AppState() {
    _member = null;
    _loading = true;
    _publicRooms = <Room>[];
    _myRooms = <MyRoom>[];
  }

  Member get member => _member;
  bool get loading => _loading;
  List<Room> get publicRooms => _publicRooms;
  List<MyRoom> get myRooms => _myRooms;
  MyRoom get currentRoom => _currentRoom;

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

  Future<void> fetchPublicRooms() async {
    _loading = true;
    notifyListeners();

    var apiResp = await roomApi().requestPublicRooms();
    List<Room> rooms = apiResp.list;
    _publicRooms = rooms;
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

    var apiResp = await roomApi().requestPublicRooms();
    _publicRooms = apiResp.list;
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
    @required dynamic content
  }) async {
    if (_currentRoom == null) return;
    await messageApi().requestPublishToRoom(
      roomToken: _currentRoom.roomToken,
      memberToken: _member.token,
      type: type,
      content: content
    );
  }
}