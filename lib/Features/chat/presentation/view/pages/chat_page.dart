import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/presentation/cubit/cubit/chat_cubit.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_page_appbar.dart';
import 'package:true_gym/Features/chat/presentation/view/widgets/chat_page_body.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.toUser});
  final UserModel toUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCubit>(context).getAllMessages(widget.toUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatPageAppbar(
          name: "${widget.toUser.fname} ${widget.toUser.lname}",
          image: widget.toUser.image),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ChatPageBody(toUser: widget.toUser),
      ),
    );
  }
}
