import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/search/data/repositories/get_search_users_repo.dart';
import 'package:linkify/Features/search/presentation/cubit/get_search_user/get_search_user_cubit.dart';
import 'package:linkify/Features/search/presentation/views/widgets/search_appbar.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';

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
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) => Text(state.users[index].fname),
              );
            } else if (state is GetSearchUserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetSearchUserError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
