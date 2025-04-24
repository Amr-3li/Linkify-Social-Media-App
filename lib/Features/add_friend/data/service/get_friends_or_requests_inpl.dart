// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/add_friend/data/service/get_friends_or_requests.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFriendsOrRequestsInpl implements GetFriendsOrRequests {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SharedPreferences? prefs;

  List<UserModel> _globalfriends = [];
  List<UserModel> _globalYourRequests = [];
  List<UserModel> _globalFriendRequests = [];
  int friendsCount = 0;
  int yourRequestsCount = 0;
  int friendRequestsCount = 0;
  @override
  Future<List<UserModel>> getUserFrinds() async {
    final friendIds = await _getFriendIds();
    List<String> localfriendIds = [];
    for (int i = friendsCount; i < (friendsCount + 10); i++) {
      if (i < friendIds.length) {
        localfriendIds.add(friendIds[i]);
      } else {
        break;
      }
    }
    final snapshot = await firestore
        .collection('users')
        .where('uid', whereIn: localfriendIds)
        .get();
    _globalfriends
        .addAll(snapshot.docs.map((doc) => UserModel.fromJson(doc.data())));
    friendsCount += 10;
    return _globalfriends;
  }

  @override
  Future<List<UserModel>> getYourRequests() async {
    final friendIds = await _getYourRequestIds();
    List<String> localfriendIds = [];
    for (int i = yourRequestsCount; i < (yourRequestsCount + 10); i++) {
      if (i < friendIds.length) {
        localfriendIds.add(friendIds[i]);
      } else {
        break;
      }
    }
    final snapshot = await firestore
        .collection('users')
        .where('uid', whereIn: localfriendIds)
        .get();
    _globalYourRequests
        .addAll(snapshot.docs.map((doc) => UserModel.fromJson(doc.data())));
    yourRequestsCount += 10;
    return _globalYourRequests;
  }

  @override
  Future<List<UserModel>> getFriendRequests() async {
    final friendIds = await _getFriendRequestIds();
    List<String> localfriendIds = [];
    for (int i = friendRequestsCount; i < (friendRequestsCount + 10); i++) {
      if (i < friendIds.length) {
        localfriendIds.add(friendIds[i]);
      } else {
        break;
      }
    }
    final snapshot = await firestore
        .collection('users')
        .where('uid', whereIn: localfriendIds)
        .get();
    _globalFriendRequests
        .addAll(snapshot.docs.map((doc) => UserModel.fromJson(doc.data())));
    friendRequestsCount += 10;
    return _globalFriendRequests;
  }

//=========================== Get Friend Ids ================================

  Future<List<String>> _getFriendIds() async {
    prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs!.getString('uid');
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
    return friendIds.toList();
  }

  Future<List<String>> _getYourRequestIds() async {
    prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs!.getString('uid');
    final sent = await firestore
        .collection('friendships')
        .where('senderId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'requested')
        .get();
    final friendIds = <String>{};
    for (var doc in sent.docs) {
      friendIds.add(doc['receiverId']);
    }
    return friendIds.toList();
  }

  Future<List<String>> _getFriendRequestIds() async {
    prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs!.getString('uid');
    final received = await firestore
        .collection('friendships')
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'accepted')
        .get();
    final friendIds = <String>{};
    for (var doc in received.docs) {
      friendIds.add(doc['senderId']);
    }

    return friendIds.toList();
  }
  //==========================================================================
}
