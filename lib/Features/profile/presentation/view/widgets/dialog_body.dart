// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/input_data_widgit.dart';
import 'package:true_gym/views/widgets/input_text.dart';

class DialogBody extends StatelessWidget {
  const DialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fnameController = TextEditingController();
    TextEditingController lnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController hightController = TextEditingController();
    TextEditingController widthController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 400,
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
            controller: fnameController,
            text: "aaaaa",
            title: "first name",
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 52, 94),
                ),
                child: const Text('Add Task',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
