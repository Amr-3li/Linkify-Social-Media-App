import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/friends/data/service/get_friends_or_requests.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class GetFriendsOrRequestsImpl implements GetFriendsOrRequests {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<UserModel> _globalFriends = [];
  final List<UserModel> _globalYourRequests = [];
  final List<UserModel> _globalFriendRequests = [];

  int _friendsCount = 0;
  int _yourRequestsCount = 0;
  int _friendRequestsCount = 0;

  Future<String> _getCurrentUserId() async {
    return SharedPreferenceSingelton.getString('uid')!;
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
  Future<List<UserModel>> initialUserFrinds() async {
    _globalFriends.clear();
    _friendsCount = 0;
    return getUserFrinds();
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
  Future<List<UserModel>> initialYourRequests() async {
    _globalYourRequests.clear();
    _yourRequestsCount = 0;
    return getYourRequests();
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

  @override
  Future<List<UserModel>> initialFriendRequests() async {
    _globalFriendRequests.clear();
    _friendRequestsCount = 0;
    return getFriendRequests();
  }

  Future<List<UserModel>> _getUsersByRelation(
      List<UserModel> globalList,
      Future<List<dynamic>> Function() getIds,
      int currentCount,
      Function(int) updateCount) async {
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

  Future<List<dynamic>> _getFriendIds() async {
    try {
      final currentUserId = await _getCurrentUserId();
      final snapshot = await _firestore
          .collection('friendRequests')
          .where('status', isEqualTo: "Accepted")
          .where(Filter.or(
            Filter('senderId', isEqualTo: currentUserId),
            Filter('receiverId', isEqualTo: currentUserId),
          ))
          .get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return data['senderId'] == currentUserId
            ? data['receiverId']
            : data['senderId'];
      }).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  Future<List<String>> _getYourRequestIds() async {
    try {
      final currentUserId = await _getCurrentUserId();
      final sent = await _firestore
          .collection('friendRequests')
          .where('senderId', isEqualTo: currentUserId)
          .where('status', isEqualTo: "Requested")
          .get();

      return sent.docs.map((doc) => doc['receiverId'] as String).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  Future<List<String>> _getFriendRequestIds() async {
    try {
      final currentUserId = await _getCurrentUserId();
      final received = await _firestore
          .collection('friendRequests')
          .where('receiverId', isEqualTo: currentUserId)
          .where('status', isEqualTo: "Requested")
          .get();

      return received.docs.map((doc) => doc['senderId'] as String).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }
}
