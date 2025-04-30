import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/friends/presentation/cubit/get_your_requests/get_your_requests_cubit.dart';
import 'package:linkify/Features/friends/presentation/view/widgets/my_request_item.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyRequestsList extends StatelessWidget {
  const MyRequestsList({
    super.key,
  });
  Future<void> _onRefresh(BuildContext context) async {
    await BlocProvider.of<GetYourRequestsCubit>(context).getYourRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetYourRequestsCubit, GetYourRequestsState>(
      builder: (context, state) {
        if (state is GetYourRequestsLoading) {
          return Skeletonizer(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const ListTile(
                    leading: CircleAvatar(radius: 20),
                    title: Text(" asf asdf asdf "));
              },
            ),
          );
        }
        if (state is GetYourRequestsLoaded && state.users.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return MyRequestItem(
                user: state.users[index],
              );
            },
          );
        } else {
          return Column(
            children: [
              const Spacer(),
              LottieBuilder.asset(MyAnimation.animationsNotExist),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _onRefresh(context),
                  child: const Text("try again")),
              const Spacer()
            ],
          );
        }
      },
    );
  }
}
