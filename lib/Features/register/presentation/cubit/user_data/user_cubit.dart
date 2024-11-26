// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  CollectionReference collRef = FirebaseFirestore.instance.collection('Users');
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

  Future<void> updateUser(UserModel user) async {
    emit(UserLoading());
    try {
      await collRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'phone': user.phone,
        'image': user.image,
        'last_active': user.lastActive.toIso8601String(),
        'isPatient': user.isPatient,
        'weight': user.weight,
        'height': user.height,
        'isMale': user.isMale,
      });
      emit(UserLoaded(user));
    } on FirebaseAuthException catch (e) {
      emit(UserError(e.code.toString()));
    }
  }
}
