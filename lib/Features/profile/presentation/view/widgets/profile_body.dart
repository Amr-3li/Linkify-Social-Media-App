import 'package:flutter/material.dart';
import 'package:true_gym/consts.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: MyColors.shadowColor,
                  blurRadius: 20,
                  offset: Offset(0, 10))
            ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child:
          const Column(children: [
            
          ])
          ),
    );
  }
}
