import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/notifications/data/model/notification_model.dart';
import 'package:linkify/Features/notifications/data/services/get_notifications.dart';

class GetNotificationsImpl implements GetNotifications {
  final FirebaseFirestore firestore;
  FirebaseAuth auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;
  GetNotificationsImpl(this.firestore);
  @override
  Future<List<NotificationModel>> getNotifications() async {
    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .orderBy('time', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => NotificationModel.fromJson(doc.data()))
        .toList();
  }
}
