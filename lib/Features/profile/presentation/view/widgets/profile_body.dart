import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/dialog_body.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/profile_information.dart';
import 'package:linkify/Features/register/data/model/user.dart';
import 'package:linkify/Features/register/data/repository/auth_repo.dart';
import 'package:linkify/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/widgets/custom_button.dart';
import 'package:linkify/get_it.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
              child: ProfileInformation(user: widget.user),
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: "Edit Profile",
              color: const Color.fromARGB(159, 165, 165, 165),
              onTap: () async {
                await openDialog();
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            BlocProvider(
              create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return state is SigninLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          title: "Log Out",
                          color: const Color.fromARGB(171, 112, 8, 1),
                          onTap: () async {
                            await BlocProvider.of<AuthCubit>(context).signout();
                            GoRouter.of(context).push('/loginPage');
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(10),
          content: BlocProvider(
            create: (context) => UserCubit(),
            child: DialogBody(
              user: widget.user,
            ),
          ),
        ),
      );
}
