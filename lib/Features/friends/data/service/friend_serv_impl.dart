import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/friends/data/model/friend_request_model.dart';
import 'package:linkify/Features/friends/data/service/friend_serv.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class AddFriendServImpl implements FriendServ {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> _getCurrentUserId() async {
    return SharedPreferenceSingelton.getString("uid")!;
  }

  @override
  Future<void> sendFriendRequest(String toId) async {
    try {
      final fromId = await _getCurrentUserId();
      final friendRequest = FriendRequestModel(
        senderId: fromId,
        receiverId: toId,
        status: "Requested",
      );
      await firestore
          .collection('friendRequests')
          .doc("$fromId-$toId")
          .set(friendRequest.toJson());
      final notification = NotificationModel(
        time: DateTime.now().microsecondsSinceEpoch.toString(),
        fromUserId: fromId,
        fromUserName: SharedPreferenceSingelton.getString('userName')!,
        fromUserImage: SharedPreferenceSingelton.getString('userImage'),
        isreading: false,
        numOfTypeReations: 0,
        discription: "sent you friend request",
        type: 'friendRequest',
        postId: toId,
      );
      await firestore
          .collection('users')
          .doc(toId)
          .collection('notifications')
          .doc("$fromId-request")
          .set(notification.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<void> unSendFriendRequest(String toId) async {
    try {
      final fromId = await _getCurrentUserId();
      await firestore
          .collection('friendRequests')
          .doc("$fromId-$toId")
          .delete();
      await firestore
          .collection('users')
          .doc(toId)
          .collection('notifications')
          .doc("$fromId-request")
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<void> acceptFriendRequest(String fromId) async {
    try {
      final toId = await _getCurrentUserId();
      await firestore
          .collection('friendRequests')
          .doc("$fromId-$toId")
          .update({"status": "Accepted"});

      await firestore
          .collection('users')
          .doc(toId)
          .collection('notifications')
          .doc("$fromId-request")
          .delete();
      final notification = NotificationModel(
          time: DateTime.now().microsecondsSinceEpoch.toString(),
          fromUserId: toId,
          fromUserName: SharedPreferenceSingelton.getString('userName')!,
          fromUserImage: SharedPreferenceSingelton.getString('userImage'),
          isreading: false,
          numOfTypeReations: 0,
          discription: "accepted your friend request",
          type: 'yourRequestIsAccepted',
          postId: fromId);
      await firestore
          .collection('users')
          .doc(fromId)
          .collection('notifications')
          .doc("$toId-request")
          .set(notification.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<void> rejectFriendRequest(String fromId) async {
    try {
      final toId = await _getCurrentUserId();
      await firestore
          .collection('friendRequests')
          .doc("$fromId-$toId")
          .delete();
      await firestore
          .collection('users')
          .doc(fromId)
          .collection('notifications')
          .doc("$toId-request")
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<void> removeFriend(String toId) async {
    try {
      final fromId = await _getCurrentUserId();

      final doc1 = await firestore
          .collection("friendRequests")
          .doc("$fromId-$toId")
          .get();

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
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }
}
