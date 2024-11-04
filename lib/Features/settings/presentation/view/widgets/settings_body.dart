import 'package:flutter/material.dart';
import 'package:true_gym/consts.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    String currentTheme = "dark";
    String currentLanguage = "english";
    return Column(
      children: [
        const ListTile(
          title: Text("GENERAL  ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          tileColor: Color.fromARGB(255, 195, 204, 205),
        ),
        ListTile(
          leading: const Icon(Icons.language, color: MyColors.iconColor),
          title: Row(
            children: [
              const Text(
                "language",
                style: TextStyle(fontSize: 18),
              ),
              const Spacer(),
              Text(currentLanguage, style: const TextStyle(fontSize: 15)),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
        ListTile(
            leading: const Icon(Icons.brightness_4, color: MyColors.iconColor),
            title: Row(
              children: [
                const Text(
                  "theme",
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(currentTheme,
                    style: const TextStyle(
                        fontSize: 15, color: MyColors.iconColor)),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_drop_down)
              ],
            )),
      ],
    );
  }
}
