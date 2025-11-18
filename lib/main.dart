import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/settings/presentation/cubit/change_theme/change_theme_cubit.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/services/local_notification_services.dart';
import 'package:linkify/core/services/push_notification_services.dart';
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
  //shared preference

  await SharedPreferenceSingelton.init();
  //notification
  await PushNotificationServices.initialize();
  await LocalNotificationService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //supabase
  await Supabase.initialize(
      url: ProjectEndpoints.storageUrl,
      anonKey: ProjectEndpoints.storageSecretKey);
  //git it
  setUpGitIt();
  //localization
  await EasyLocalization.ensureInitialized();

  runApp(DevicePreview(
    builder: (context) => BlocProvider(
      create: (context) => ChangeThemeCubit(),
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: "assets/lang", // Path to your translation files
          fallbackLocale: Locale('en '),
          child: const MyApp()),
    ),
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
          //for localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          //==========================
          routerConfig: AppRouter.appRouter,
          title: 'Linkify',
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.slowMiddle,
          themeAnimationDuration: const Duration(milliseconds: 300),
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
