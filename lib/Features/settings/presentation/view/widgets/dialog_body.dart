// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/input_data_widgit.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

class DialogBody extends StatelessWidget {
  const DialogBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = user;
    String fname = userModel.name.split(' ')[0],
        lname = userModel.name.split(' ')[1];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'update user data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1, color: Colors.black),
            const SizedBox(height: 10),
            InputDataWidgit(
              text: fname,
              title: "first name",
              onchanged: (value) {
                fname = value;
                userModel.name = "$fname $lname";
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: lname,
              title: "last name",
              onchanged: (value) {
                lname = value;
                userModel.name = "$fname $lname";
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: userModel.email,
              title: "Email",
              onchanged: (value) {
                userModel.email = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: userModel.phone,
              title: "phone",
              isnumber: true,
              onchanged: (value) {
                userModel.phone = value;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                BlocProvider(
                  create: (context) => UpdateUserCubit(
                      gitItInstanse<ImageRepo>(),
                      gitItInstanse<UserDataRepo>()),
                  child: BlocBuilder<UpdateUserCubit, UpdateUserState>(
                    builder: (context, state) {
                      return Expanded(
                        child: state is UpdateUserLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  await BlocProvider.of<UpdateUserCubit>(
                                          context)
                                      .updateUser(userModel);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 1, 52, 94),
                                ),
                                child: const Text('save',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
