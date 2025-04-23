import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/add_friend/data/model/friend_request_model.dart';
import 'package:linkify/Features/add_friend/data/service/add_friend_serv.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class AddFriendServImpl implements AddFriendServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<UserModel>> getUserFrinds(String id) async {
    final friendIds = await getFriendIds(id);
    final snapshot = await firestore.collection('users').get();
    return snapshot.docs
        .where((doc) => friendIds.contains(doc['uid']))
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<void> sendFriendRequest(String fromId, String toId) {
    // TODO: implement sendFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> unSendFriendRequest(String fromId, String toId) {
    // TODO: implement unSendFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUserRequests(String id) {
    // TODO: implement getUserRequests
    throw UnimplementedError();
  }

  Future<List<String>> getFriendIds(String currentUserId) async {
    final firestore = FirebaseFirestore.instance;
    final sent = await firestore
        .collection('friendships')
        .where('senderId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'accepted')
        .get();
    final received = await firestore
        .collection('friendships')
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'accepted')
        .get();
    final friendIds = <String>{};
    for (var doc in sent.docs) {
      friendIds.add(doc['receiverId']);
    }
    for (var doc in received.docs) {
      friendIds.add(doc['senderId']);
    }
    friendIds.add(currentUserId); // استبعد نفسك كمان
    return friendIds.toList();
  }

  Future<List<String>> getYourRequest(String currentUserId) async {
    final firestore = FirebaseFirestore.instance;
    final sent = await firestore
        .collection('friendships')
        .where('senderId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'requested')
        .get();
    final friendIds = <String>{};
    for (var doc in sent.docs) {
      friendIds.add(doc['receiverId']);
    }
    friendIds.add(currentUserId); // استبعد نفسك كمان
    return friendIds.toList();
  }

  Future<List<String>> getFriendRequestIds(String currentUserId) async {
    final firestore = FirebaseFirestore.instance;
    final received = await firestore
        .collection('friendships')
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'accepted')
        .get();
    final friendIds = <String>{};
    for (var doc in received.docs) {
      friendIds.add(doc['senderId']);
    }
    friendIds.add(currentUserId); // استبع نفسك كمان
    return friendIds.toList();
  }
}
