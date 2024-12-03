// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/input_data_widgit.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';

class DialogBody extends StatelessWidget {
  const DialogBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = user;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Task information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1, color: Colors.black),
            const SizedBox(height: 10),
            InputDataWidgit(
              text: userModel.fname,
              title: "first name",
              onchanged: (value) {
                userModel.fname = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: userModel.lname,
              title: "last name",
              onchanged: (value) {
                userModel.lname = value;
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
            InputDataWidgit(
              text: userModel.weight.toString(),
              title: "weight",
              isnumber: true,
              onchanged: (value) {
                userModel.weight = double.parse(value);
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: userModel.height.toString(),
              title: "hight",
              isnumber: true,
              onchanged: (value) {
                userModel.height = double.parse(value);
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
                  create: (context) => UserCubit(),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return Expanded(
                        child: state is UserLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  await BlocProvider.of<UserCubit>(context)
                                      .updateUser(userModel);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 1, 52, 94),
                                ),
                                child: const Text('Done',
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
