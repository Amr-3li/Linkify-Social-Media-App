// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userDataRepo) : super(UserInitial());
  final UserDataRepo userDataRepo;
  CollectionReference collRef = FirebaseFirestore.instance.collection('users');
  Future<void> getUserData(String userId) async {
    emit(UserLoading());
    final result = await userDataRepo.getUserById(userId);
    result.fold(
      (l) {
        UserError(l.errMessage);
      },
      (r) {
        UserLoaded(r);
      },
    );
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
