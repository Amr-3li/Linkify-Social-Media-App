import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/cubit/change_theme/change_theme_cubit.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';
import 'package:linkify/core/utils/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SharedPreferenceSingelton.init();
  setUpGitIt();

  runApp(BlocProvider(
    create: (context) => ChangeThemeCubit(),
    child: const MyApp(),
  ));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
      builder: (context, themeState) {
        return MaterialApp.router(
          routerConfig: AppRouter.appRouter,
          title: 'Linkify',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme, // Light theme
          darkTheme: AppTheme.darkTheme, // Dark theme
          themeMode: themeState is ChangeThemeLoaded
              ? (themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light)
              : ThemeMode.system, // Fallback to system if not loaded
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
              },
            );
          },
        );
      },
    );
  }
}
