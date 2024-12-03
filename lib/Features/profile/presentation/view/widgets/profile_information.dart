import 'package:flutter/material.dart';
import 'package:true_gym/Features/profile/presentation/view/widgets/information_component.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        InformationComponent(
            type: "Email",
            text: user.email,
            icon: const Icon(Icons.email, color: Colors.red)),
        const SizedBox(height: 20),
        InformationComponent(
          type: "Name",
          text: "${user.fname} ${user.lname}",
          icon: const Icon(Icons.person, color: Colors.blueAccent),
        ),
        const SizedBox(height: 20),
        InformationComponent(
          type: "Phone ",
          text: user.phone,
          icon: const Icon(
            Icons.phone,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 20),
        InformationComponent(
          type: "Gender ",
          text: user.isMale ? "Male" : "Female",
          icon: Icon(
            user.isMale ? Icons.male : Icons.female,
            color: user.isMale ? Colors.blue : Colors.pink,
          ),
        ),
        const SizedBox(height: 20),
        InformationComponent(
          type: "hight ",
          text: user.height.toString(),
          icon: const Icon(
            Icons.height,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        InformationComponent(
          type: "weight ",
          text: user.weight.toString(),
          icon: const Icon(
            Icons.accessibility_outlined,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 20),
        InformationComponent(
          type: "Date ",
          text: user.lastActive.toString(),
          icon: const Icon(
            Icons.calendar_month,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        // Add more user details here
      ],
    );
  }
}
