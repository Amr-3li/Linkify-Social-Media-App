import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/Features/search/data/services/get_search_users.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class GetSearchUsersImpl implements GetSearchUsers {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<UserModel>> getUsersBySearch(String search) async {
    final querySnapshot = await firestore
        .collection('users')
        .where('searchWords', arrayContains: search.trim().toLowerCase())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return search == ""
          ? []
          : querySnapshot.docs
              .map((doc) => UserModel.fromJson(doc.data()))
              .toList();
    } else {
      return [];
    }
  }
}
