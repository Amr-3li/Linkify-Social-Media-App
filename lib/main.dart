import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:linkify/Features/connectivity/disconnected_page.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/utils/app_router.dart';
import 'package:linkify/core/utils/project_endpoints.dart';
import 'package:linkify/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
      url: ProjectEndpoints.storageUrl,
      anonKey: ProjectEndpoints.storageSecretKey);
  setUpGitIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.appRouter,
      title: 'Linkify',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return StreamBuilder<List<ConnectivityResult>>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.contains(ConnectivityResult.none)) {
                  return const DisconnectedPage();
                }
              }
              return child!;
            });
      },
    );
  }
}
