import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/static_pages/pages/about_us_paga.dart';
import 'package:linkify/Features/static_pages/pages/help_page.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:linkify/Features/home/presentation/view/widgets/user_drawer_information.dart';
import 'package:linkify/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/constants/colors.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is CurrentUserLoaded) {
              UserModel user = state.user;
              return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    GoRouter.of(context).push('/profilePage/${user.id}');
                  },
                  child: UserDrawerInformation(
                      name: user.name, email: user.email, image: user.image!));
            } else if (state is CurrentUserLoading) {
              return const Skeletonizer(
                  child: UserDrawerInformation(
                name: Constants.skeltonizerTextSmall2,
                email: Constants.skeltonizerTextSmall3,
                image: "",
              ));
            } else if (state is CurrentUserError) {
              return Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(state.message.toString(),
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.help, color: MyColors.iconColor),
          title: const Text(Constants.help,
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () => GoRouter.of(context).push(HelpPage.routeName),
        ),
        ListTile(
          leading: const Icon(Icons.info, color: MyColors.iconColor),
          title: const Text(Constants.aboutUs,
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () => GoRouter.of(context).push(AboutUsPaga.routeName),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.share, color: MyColors.iconColor),
          title: Text(Constants.share,
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
        ),
        const ListTile(
          leading: Icon(Icons.rate_review, color: MyColors.iconColor),
          title: Text(Constants.rateUs,
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
        ),
        const Divider(),
        ListTile(
          leading:
              const Icon(Icons.logout, color: Color.fromARGB(255, 198, 0, 0)),
          title: const Text(Constants.logout,
              style: TextStyle(color: MyColors.fontColor, fontSize: 20)),
          onTap: () async {
            Navigator.pop(context);
            await BlocProvider.of<AuthCubit>(context).signout();
            GoRouter.of(context).push('/loginPage');
          },
        ),
      ],
    );
  }
}
