import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/data/services/get_notifications.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';

class GetNotificationsImpl implements GetNotifications {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;
  DocumentSnapshot? _lastDoc;
  bool _hasMore = true;
  @override
  Future<List<NotificationModel>> getNotifications(
      {bool refresh = false}) async {
    try {
      if (refresh) {
        _lastDoc = null;
        _hasMore = true;
      }
      if (!_hasMore) return [];
      Query query = firestore
          .collection('users')
          .doc(user.uid)
          .collection('notifications')
          .orderBy('time', descending: true)
          .limit(10);
      if (_lastDoc != null) {
        query = query.startAfterDocument(_lastDoc!);
      }
      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        _lastDoc = snapshot.docs.last;
      }
      if (snapshot.docs.length < 10) {
        _hasMore = false;
      }
      return snapshot.docs
          .map((doc) =>
              NotificationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('notifications')
          .doc(notificationId)
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }

  @override
  Future<void> readAllNotifications() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw 'User not authenticated';

      final notificationsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('notifications');
      final querySnapshot =
          await notificationsRef.where('isReading', isEqualTo: false).get();
      print('Number of unread notifications: ${querySnapshot.docs.length}');
      final batch = FirebaseFirestore.instance.batch();

      for (final doc in querySnapshot.docs) {
        batch.update(doc.reference, {'isReading': true});
      }
      if (querySnapshot.docs.isNotEmpty) {
        await batch.commit();
      }
      print('All notifications marked as read.' +
          querySnapshot.docs.length.toString());
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw 'Failed to update notifications. Please try again.';
    }
  }

  @override
  bool get hasMore => _hasMore;
  @override
  void resetPagination() {
    _lastDoc = null;
    _hasMore = true;
  }
}
