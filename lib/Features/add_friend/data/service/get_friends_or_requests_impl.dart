import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/add_friend/data/service/get_friends_or_requests.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFriendsOrRequestsImpl implements GetFriendsOrRequests {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  SharedPreferences? _prefs;

  final List<UserModel> _globalFriends = [];
  final List<UserModel> _globalYourRequests = [];
  final List<UserModel> _globalFriendRequests = [];

  int _friendsCount = 0;
  int _yourRequestsCount = 0;
  int _friendRequestsCount = 0;

  Future<String> _getCurrentUserId() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString('uid')!;
  }

  @override
  Future<List<UserModel>> getUserFrinds() async {
    return await _getUsersByRelation(
      _globalFriends,
      _getFriendIds,
      _friendsCount,
      (count) => _friendsCount = count,
    );
  }

  @override
  Future<List<UserModel>> getYourRequests() async {
    return await _getUsersByRelation(
      _globalYourRequests,
      _getYourRequestIds,
      _yourRequestsCount,
      (count) => _yourRequestsCount = count,
    );
  }

  @override
  Future<List<UserModel>> getFriendRequests() async {
    return await _getUsersByRelation(
      _globalFriendRequests,
      _getFriendRequestIds,
      _friendRequestsCount,
      (count) => _friendRequestsCount = count,
    );
  }

  Future<List<UserModel>> _getUsersByRelation(
    List<UserModel> globalList,
    Future<List<String>> Function() getIds,
    int currentCount,
    Function(int) updateCount,
  ) async {
    final ids = await getIds();
    if (ids.isEmpty) return globalList;

    final List<String> localIds = [];
    for (int i = currentCount; i < currentCount + 10 && i < ids.length; i++) {
      localIds.add(ids[i]);
    }
    if (localIds.isEmpty) return globalList;
    final snapshot = await _firestore
        .collection('users')
        .where('uid', whereIn: localIds)
        .get();

    globalList
        .addAll(snapshot.docs.map((doc) => UserModel.fromJson(doc.data())));
    updateCount(currentCount + 10);
    return globalList;
  }

  Future<List<String>> _getFriendIds() async {
    final currentUserId = await _getCurrentUserId();
    final sent = await _firestore
        .collection('friendRequests')
        .where('senderId', isEqualTo: currentUserId)
        .where('status', isEqualTo: Constants.accepted)
        .get();

    final received = await _firestore
        .collection('friendRequests')
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: Constants.accepted)
        .get();

    final friendIds = <String>{};
    friendIds.addAll(sent.docs.map((doc) => doc['receiverId']));
    friendIds.addAll(received.docs.map((doc) => doc['senderId']));

    return friendIds.toList();
  }

  Future<List<String>> _getYourRequestIds() async {
    final currentUserId = await _getCurrentUserId();
    final sent = await _firestore
        .collection('friendRequests')
        .where('senderId', isEqualTo: currentUserId)
        .where('status', isEqualTo: Constants.requested)
        .get();

    return sent.docs.map((doc) => doc['receiverId'] as String).toList();
  }

  Future<List<String>> _getFriendRequestIds() async {
    final currentUserId = await _getCurrentUserId();
    print(currentUserId);
    final received = await _firestore
        .collection('friendRequests')
        .where('receiverId', isEqualTo: currentUserId)
        .where('status', isEqualTo: Constants.requested)
        .get();

    return received.docs.map((doc) => doc['senderId'] as String).toList();
  }
}
