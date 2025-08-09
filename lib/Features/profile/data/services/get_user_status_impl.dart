import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/profile/data/services/get_user_status.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_sengelton.dart';
import 'package:path/path.dart';

class GetUserStatusImpl implements GetUserStatus {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<String> userStatus(String toId) async {
    try {
      final myId = SharedPreferenceSengelton.getString('uid');
      if (equals(toId, myId)) {
        return Constants.myAccount;
      } else {
        final response1 = await firestore
            .collection('friendRequests')
            .doc("$myId-$toId")
            .get();
        if (response1.exists) {
          String status = response1.data()!["status"];
          if (equals(status, Constants.requested)) {
            return Constants.youSendRequest;
          } else if (equals(status, Constants.accepted)) {
            return Constants.friends;
          }
        } else {
          final response1 = await firestore
              .collection('friendRequests')
              .doc("$toId-$myId")
              .get();
          if (response1.exists) {
            String status = response1.data()!["status"];
            if (equals(status, Constants.requested)) {
              return Constants.friendSendRequest;
            } else if (equals(status, Constants.accepted)) {
              return Constants.friends;
            }
          }
        }
      }
      return Constants.noRelation;
    } on FirebaseException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseFirestoreError(e);
    } catch (e) {
      throw "something went wrong";
    }
  }
}
