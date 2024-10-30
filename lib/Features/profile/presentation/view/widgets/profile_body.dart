import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/bloc/cubit/user_data/user_cubit.dart';
import 'package:true_gym/consts.dart';
import 'package:true_gym/data/models/user.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
              width: double.infinity,
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
              child: BlocProvider(
                create: (context) => UserCubit()..getUserData(),
                child: const ProfileInformation(),
              )),
        ],
      ),
    );
  }
}

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({
    super.key,
  });

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  late UserModel user;
  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          // Show a loading indicator while the data is being fetched
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          // Show user data when loaded
          final user = state.user;
          return Column(
            children: [
              const SizedBox(height: 20),
              Text("Email: ${user.email}"),
              const SizedBox(height: 20),
              Text("Name: ${user.name}"),
              const SizedBox(height: 20),
              Text("phone: ${user.phone}"),
              // Add more user details here
            ],
          );
        } else if (state is UserError) {
          // Show an error message if something goes wrong
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink(); // Show nothing by default
      },
    );
  }
}
