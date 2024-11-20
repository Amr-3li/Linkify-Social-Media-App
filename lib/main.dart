import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:true_gym/Features/register/data/web_servecies/get_it_ser.dart';
import 'package:true_gym/Features/splash_screan/splash_screan.dart';
import 'package:true_gym/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpGitIt();

  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'True Gym',
      debugShowCheckedModeBanner: false,
      home: SplashScrean(),
    );
  }
}
