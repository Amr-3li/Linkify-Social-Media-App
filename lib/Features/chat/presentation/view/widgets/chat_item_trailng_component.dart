import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:linkify/Features/chat/data/model/message_model.dart';
import 'package:linkify/Features/chat/presentation/cubit/message_count/message_count_cubit.dart';
import 'package:linkify/core/constants/colors.dart';

class ChatItemTrailingComponent extends StatelessWidget {
  const ChatItemTrailingComponent({
    super.key,
    required this.time,
  });
  final String time;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCountCubit, MessageCountState>(
      builder: (context, state) {
        return state is MessageCountLoaded
            ? StreamBuilder(
                stream: state.count,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for data
                    return const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    );
                  } else if (snapshot.hasError) {
                    // Show an error message if the stream emits an error
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 16,
                    );
                  } else if (!snapshot.hasData || snapshot.data!.size == 0) {
                    // If there's no data or the count is 0, show nothing
                    return const SizedBox();
                  } else {
                    // Display the count of unread messages
                    var format = DateFormat('dd/MM/yyyy');
                    dynamic dateString = format.format(
                        DateTime.fromMillisecondsSinceEpoch(int.parse(snapshot
                            .data!.docs
                            .map((e) => MessageModel.fromJson(e.data()))
                            .last
                            .time)));

                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.green,
                            child: Text(
                              snapshot.data!.size.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            dateString,
                            style: const TextStyle(
                                color: MyColors.fontColor, fontSize: 12),
                          ),
                        ]);
                  }
                })
            : const SizedBox();
      },
    );
  }
}
