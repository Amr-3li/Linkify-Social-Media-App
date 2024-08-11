import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/bloc/cubit/auth/auth_cubit.dart';
import 'package:true_gym/data/repository/auth_repo.dart';
import 'package:true_gym/data/web_ser/user_auth/auth.dart';
import 'package:true_gym/firebase_options.dart';
import 'package:true_gym/views/pages/register_pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Gym',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthCubit(AuthRepository(AuthWebservice())),
        child: const LoginPage(),
      ),
    );
  }
}
