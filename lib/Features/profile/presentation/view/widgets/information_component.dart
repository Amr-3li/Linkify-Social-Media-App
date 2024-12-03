import 'package:flutter/material.dart';

class InformationComponent extends StatelessWidget {
  const InformationComponent({
    super.key,
    required this.text,
    required this.icon,
    required this.type,
  });

  final String type, text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(150, 208, 208, 208),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              " $type:   $text",
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          icon
        ],
      ),
    );
  }
}
