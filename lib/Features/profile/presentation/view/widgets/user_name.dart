import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  const UserName({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: name.length > 30
          ? Text(
              name,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            )
          : FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: name.length > 15 ? 30 : 40,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
