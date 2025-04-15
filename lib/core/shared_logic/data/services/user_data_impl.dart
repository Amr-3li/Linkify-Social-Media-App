import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/services/users_data.dart';

class UserDataImpl implements UsersData {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User get user => auth.currentUser!;
  @override
  Future<void> deleteUser() async {
    await auth.currentUser!.delete();
    await firestore.collection('users').doc(user.uid).delete();
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> users = [];
    await firestore.collection('users').get().then((value) {
      users = value.docs.map((e) => UserModel.fromJson(e.data())).toList();
    });

    return users;
  }

  @override
  Future<UserModel> getUserById(String id) async {
    try {
      final docSnapshot = await firestore.collection('users').doc(id).get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        throw Exception("User not found or data is null for ID: $id");
      }
      final userData = docSnapshot.data()!;
      UserModel user = UserModel.fromJson(userData);
      return user;
    } catch (e) {
      debugPrint("Error in getUserById: $e");
      rethrow; // علشان نرمي الخطأ ونخليه يوصل للطبقة اللي فوق
    }
  }

  @override
  Future<List<UserModel>> getUsersBySearch(String search) async {
    try {
      final searchParts = search.split(' ');
      List<UserModel> users = [];

      final firstName = search.contains(' ') ? searchParts[0] : search;
      final lastName = search.contains(' ') ? searchParts[1] : "";

      // Query Firestore for first name
      final firstNameQuery = firestore
          .collection('users')
          .where('fname', isGreaterThanOrEqualTo: firstName)
          .where('fname', isLessThanOrEqualTo: '$firstName\uf8ff');

      final firstNameResults = await firstNameQuery.get();
      users = firstNameResults.docs
          .map((e) => UserModel.fromJson(e.data()))
          .where((user) =>
              user.lname.toLowerCase().startsWith(lastName.toLowerCase()))
          .toList();

      return users;
    } catch (e) {
      return []; // Return empty list in case of error
    }
  }

  @override
  Future<List<UserModel>> getUsersFrind(String id) {
    // TODO: implement getUsersFrind
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await firestore.collection('users').doc(user.id).update(user.toJson());
  }
}
