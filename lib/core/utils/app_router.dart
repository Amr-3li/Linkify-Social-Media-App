import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/chat/presentation/view/pages/chat_home_page.dart';
import 'package:linkify/Features/home/presentation/view/home_page.dart';
import 'package:linkify/Features/posts/presentation/view/add_post_page.dart';
import 'package:linkify/Features/profile/presentation/view/profile.dart';
import 'package:linkify/Features/register/data/repository/auth_repo.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/Features/register/data/repository/signup_repo.dart';
import 'package:linkify/Features/connectivity/disconnected_page.dart';
import 'package:linkify/core/gitit/get_it.dart';
import 'package:linkify/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/signup/signup_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/Features/register/presentation/view/pages/forgot_password_page.dart';
import 'package:linkify/Features/register/presentation/view/pages/login_page.dart';
import 'package:linkify/Features/register/presentation/view/pages/signup_page.dart';
import 'package:linkify/Features/settings/presentation/view/settings.dart';
import 'package:linkify/Features/splash_screan/splash_screan.dart';
import 'package:linkify/initial.dart';

abstract class AppRouter {
  static final appRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScrean(),
      ),
      GoRoute(
        path: '/splashScrean',
        builder: (context, state) => const SplashScrean(),
      ),
      GoRoute(
        path: '/disconnectPage',
        builder: (context, state) => const DisconnectedPage(),
      ),
      GoRoute(
        path: '/initialPage',
        builder: (context, state) => const InitialPage(),
      ),
      GoRoute(
        path: '/loginPage',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/signupPage',
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => SignUpCupit(
              gitItInstanse.get<ImageRepo>(),
              gitItInstanse.get<SignupRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
        ], child: const SignupPage()),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
          child: const ForgotPasswordPage(),
        ),
      ),
      GoRoute(
        path: '/homePage',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
            ),
            BlocProvider(
              create: (_) => UserCubit()..getUserData(),
            ),
          ],
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/profilePage',
        builder: (context, state) => BlocProvider(
          create: (context) => UserCubit()..getUserData(),
          child: const ProfilePage(),
        ),
      ),
      GoRoute(
        path: '/addPost',
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(create: (context) => UserCubit()..getUserData()),
          // BlocProvider(create: (context) =>),
        ], child: const AddPostPage()),
      ),
      GoRoute(
        path: '/chatHomePage',
        builder: (context, state) => const ChatHomePage(),
      ),
      // GoRoute(
      //   path: '/chatScrean',
      //   builder: (context, state) => const ChatPage(toUser: UserModel(),),
      // ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
