import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/add_friend/data/model/friend_request_model.dart';
import 'package:linkify/Features/add_friend/data/service/friend_serv.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFriendServImpl implements FriendServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  SharedPreferences? prefs;

  Future<String> _getCurrentUserId() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getString("uid")!;
  }

  @override
  Future<void> sendFriendRequest(String toId) async {
    final fromId = await _getCurrentUserId();
    final friendRequest = FriendRequestModel(
      senderId: fromId,
      receiverId: toId,
      status: Constants.requested,
    );

    await firestore
        .collection('friendRequests')
        .doc("$fromId-$toId")
        .set(friendRequest.toJson());
  }

  @override
  Future<void> unSendFriendRequest(String toId) async {
    final fromId = await _getCurrentUserId();
    await firestore.collection('friendRequests').doc("$fromId-$toId").delete();
  }

  @override
  Future<void> acceptFriendRequest(String fromId) async {
    final toId = await _getCurrentUserId();
    await firestore
        .collection('friendRequests')
        .doc("$fromId-$toId")
        .update({"status": Constants.accepted});
  }

  @override
  Future<void> rejectFriendRequest(String fromId) async {
    final toId = await _getCurrentUserId();
    await firestore.collection('friendRequests').doc("$fromId-$toId").delete();
  }

  @override
  Future<void> removeFriend(String toId) async {
    final fromId = await _getCurrentUserId();

    final doc1 =
        await firestore.collection("friendRequests").doc("$fromId-$toId").get();

    if (doc1.exists) {
      await firestore
          .collection("friendRequests")
          .doc("$fromId-$toId")
          .delete();
    } else {
      await firestore
          .collection("friendRequests")
          .doc("$toId-$fromId")
          .delete();
    }
  }
}
