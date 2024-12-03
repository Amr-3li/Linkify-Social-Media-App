// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/input_data_widgit.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class DialogBody extends StatelessWidget {
  const DialogBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
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
              text: user.fname,
              title: "first name",
              onchanged: (value) {
                user.fname = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: user.lname,
              title: "last name",
              onchanged: (value) {
                user.lname = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: user.email,
              title: "Email",
              onchanged: (value) {
                user.email = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: user.phone,
              title: "phone",
              isnumber: true,
              onchanged: (value) {
                user.phone = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: user.weight.toString(),
              title: "weight",
              isnumber: true,
              onchanged: (value) {
                user.weight = double.parse(value);
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: user.height.toString(),
              title: "hight",
              isnumber: true,
              onchanged: (value) {
                user.height = double.parse(value);
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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 1, 52, 94),
                    ),
                    child: const Text('Done',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
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
