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
  bool get hasMore => _hasMore;
  @override
  void resetPagination() {
    _lastDoc = null;
    _hasMore = true;
  }
}
