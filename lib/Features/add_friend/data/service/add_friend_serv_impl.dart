import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/add_friend/data/model/friend_request_model.dart';
import 'package:linkify/Features/add_friend/data/service/add_friend_serv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFriendServImpl implements AddFriendServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SharedPreferences? prefs;

  @override
  Future<void> sendFriendRequest(String toId) async {
    prefs = await SharedPreferences.getInstance();
    final fromId = prefs!.getString('uid');
    final friendRequest =
        FriendRequestModel(fromId: fromId!, toId: toId, status: 'requested');
    await firestore
        .collection('friendRequests')
        .doc("$fromId-$toId")
        .set(friendRequest.toJson());
  }

  @override
  Future<void> unSendFriendRequest(String toId) async {
    prefs = await SharedPreferences.getInstance();
    final fromId = prefs!.getString("uid");
    await firestore.collection('friendRequests').doc("$fromId-$toId").delete();
  }

  Future<void> acceptFriendRequest(String fromId) async {
    prefs = await SharedPreferences.getInstance();
    final toId = prefs!.getString("uid");
    await firestore
        .collection("friendRequests")
        .doc("$fromId-$toId")
        .update({"status": "accepted"});
  }

  Future<void> rejectFriendRequest(String fromId, String toId) async {
    prefs = await SharedPreferences.getInstance();
    final toId = prefs!.getString("uid");
    await firestore.collection("friendRequests").doc("$fromId-$toId").delete();
  }
}
