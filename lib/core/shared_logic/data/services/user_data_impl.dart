import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/services/users_data.dart';

class UserDataImpl extends UsersData {
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
    late List<UserModel> users;
    await firestore.collection('users').get().then((value) {
      users = value.docs.map((e) => UserModel.fromJson(e.data())).toList();
    });

    return users;
  }

  @override
  Future<UserModel> getUserById(String id) async {
    late UserModel user;
    await firestore.collection('users').doc(id).get().then((value) {
      user = UserModel.fromJson(value.data()!);
    });
    return user;
  }

  @override
  Future<List<UserModel>> getUsersBySearch(String search) {}

  @override
  Future<List<UserModel>> getUsersFrind(String id) {
    // TODO: implement getUsersFrind
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
