import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/search/data/repositories/get_search_users_repo.dart';
import 'package:linkify/Features/search/presentation/cubit/get_search_user/get_search_user_cubit.dart';
import 'package:linkify/Features/search/presentation/views/widgets/search_appbar.dart';
import 'package:linkify/Features/search/presentation/views/widgets/users_lisr.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetSearchUserCubit(gitItInstanse<GetSearchUsersRepo>()),
      child: Scaffold(
        appBar: const SearchAppbar(),
        body: BlocBuilder<GetSearchUserCubit, GetSearchUserState>(
          builder: (context, state) {
            if (state is GetSearchUserSuccess && state.users.isNotEmpty) {
              return UsersList(users: state.users);
            } else if (state is GetSearchUserLoading) {
              return Skeletonizer(
                child: Column(
                  children: List.generate(
                      5,
                      (index) => const ListTile(
                          leading: CircleAvatar(radius: 20),
                          title: Text("nameasdf asdfasd af"))).toList(),
                ),
              );
            } else {
              return Center(
                  child: Lottie.asset(MyAnimation.animationsNotExist,
                      repeat: false));
            }
          },
        ),
      ),
    );
  }
}
