// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  CollectionReference collRef = FirebaseFirestore.instance.collection('users');
  Future<void> getUserData() async {
    emit(UserLoading());
    try {
      UserModel? user = await collRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) =>
              UserModel.fromJson(value.data() as Map<String, dynamic>));
      if (user != null) {
        emit(UserLoaded( user));
      } else {
        emit(UserError('user not found'));
      }
    } on FirebaseAuthException catch (e) {
      emit(UserError(e.code.toString()));
    }
  }
}
