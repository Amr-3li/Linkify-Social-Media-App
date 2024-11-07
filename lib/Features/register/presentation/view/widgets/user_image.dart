import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await BlocProvider.of<UserCubit>(context).getImage();
          },
          child: state is SelectImageSuccess
              ? CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color.fromARGB(255, 130, 130, 130),
                  child: CircleAvatar(
                      radius: 58,
                      backgroundColor: Colors.white,
                      backgroundImage: FileImage(state.imageFile)))
              : Stack(children: [
                  const CircleAvatar(
                      radius: 60,
                      backgroundColor: Color.fromARGB(150, 188, 188, 188),
                      child: Icon(
                        Icons.person,
                        size: 80,
                      )),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color.fromARGB(255, 15, 0, 101),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  )
                ]),
        );
      },
    );
  }
}
