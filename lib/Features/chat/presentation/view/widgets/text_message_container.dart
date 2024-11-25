import 'package:flutter/material.dart';

class TextMaessageContainer extends StatelessWidget {
  const TextMaessageContainer({
    super.key,
    required this.message,
    required this.time,
  });
  final String message;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 50),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 199, 199, 199),
              blurRadius: 10,
              offset: Offset(0, 10),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(
                fontSize: 19, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "${time.hour}:${time.minute}",
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
