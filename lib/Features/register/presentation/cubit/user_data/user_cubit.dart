// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/register/data/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  CollectionReference collRef = FirebaseFirestore.instance.collection('users');
  Future<void> getUserData() async {
    emit(UserLoading());
    try {
      // Get the current user's UID
      final String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        emit(UserError('User is not logged in'));
        return;
      }

      // Fetch user data from Firestore
      DocumentSnapshot snapshot = await collRef.doc(userId).get();
      var data = snapshot.data();

      if (data != null) {
        UserModel user = UserModel.fromJson(data as Map<String, dynamic>);
        emit(UserLoaded(user));
      } else {
        emit(UserError('User not found in Firestore'));
      }
    } catch (e) {
      emit(UserError(e.toString())); // Handle any exception
    }
  }

  getAllUsers() async {
    // emit(UserLoading());
    // try {
    //   QuerySnapshot snapshot = await collRef.get();
    //   List<UserModel> users = snapshot.docs
    //       .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
    //       .toList();
    //   emit(AllUsersLoaded(users));
    // } catch (e) {
    //   emit(UserError(e.toString())); // Handle any exception
    // }
  }
  searchUser(String name) async {
    // emit(UserLoading());
    // try {
    //   QuerySnapshot snapshot = await collRef.where('fname', isEqualTo: name).get();
    //   List<UserModel> users = snapshot.docs
    //       .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
    //       .toList();
    //   emit(AllUsersLoaded(users));
    // } catch (e) {
    //   emit(UserError(e.toString())); // Handle any exception
    // }
  }
}
