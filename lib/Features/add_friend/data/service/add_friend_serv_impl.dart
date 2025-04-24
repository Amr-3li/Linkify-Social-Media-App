import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:linkify/Features/add_friend/data/service/add_friend_serv.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFriendServImpl implements AddFriendServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SharedPreferences? prefs;

  @override
  Future<void> sendFriendRequest(String fromId, String toId) {
    // TODO: implement sendFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> unSendFriendRequest(String toId) {}
  Future<void> SendFriendRequest(String toId) async {}

  Future<void> acceptFriendRequest(String fromId, String toId) async {}
  Future<void> rejectFriendRequest(String fromId, String toId) async {}
}
