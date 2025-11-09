// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/view/widgets/input_data_widgit.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/profile/presentation/cubit/update_user/update_user_cubit.dart';

class DialogBody extends StatelessWidget {
  const DialogBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = user;
    String fname = userModel.name.split(' ')[0],
        lname = userModel.name.split(' ')[1];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Constants.updateUserData.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Divider(
                thickness: 1, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(height: 10),
            InputDataWidgit(
              text: fname,
              title: Constants.firstName.tr(),
              color: Theme.of(context).colorScheme.onSurface,
              onchanged: (value) {
                fname = value;
                userModel.name = "$fname $lname";
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: lname,
              title: Constants.lastName.tr(),
              color: Theme.of(context).colorScheme.onSurface,
              onchanged: (value) {
                lname = value;
                userModel.name = "$fname $lname";
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: userModel.about ?? "",
              title: Constants.about.tr(),
              color: Theme.of(context).colorScheme.onSurface,
              onchanged: (value) {
                userModel.about = value;
              },
            ),
            const SizedBox(height: 20),
            InputDataWidgit(
              text: userModel.phone,
              title: Constants.phone.tr(),
              color: Theme.of(context).colorScheme.onSurface,
              isnumber: true,
              onchanged: (value) {
                userModel.phone = value;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 78, 0, 0), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surface),
                    child: Text(Constants.cansel.tr(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                BlocProvider(
                  create: (context) => UpdateUserCubit(
                      gitItInstanse<ImageRepo>(),
                      gitItInstanse<UserDataRepo>()),
                  child: BlocBuilder<UpdateUserCubit, UpdateUserState>(
                    builder: (context, state) {
                      return Expanded(
                        child: state is UpdateUserLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () async {
                                  await BlocProvider.of<UpdateUserCubit>(
                                          context)
                                      .updateUser(userModel);
                                  GoRouter.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                child: Text(Constants.save.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                      );
                    },
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
