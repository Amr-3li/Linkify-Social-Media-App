import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/chat_home_page.dart';
import 'package:true_gym/Features/chat/presentation/view/pages/chat_screan.dart';
import 'package:true_gym/Features/home/presentation/view/home_page.dart';
import 'package:true_gym/Features/posts/presentation/view/add_post_page.dart';
import 'package:true_gym/Features/profile/presentation/view/profile.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo.dart';
import 'package:true_gym/get_it.dart';
import 'package:true_gym/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:true_gym/Features/register/presentation/cubit/signup/signup_cubit.dart';
import 'package:true_gym/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:true_gym/Features/register/presentation/view/forgot_password_page.dart';
import 'package:true_gym/Features/register/presentation/view/login_page.dart';
import 'package:true_gym/Features/register/presentation/view/signup_page.dart';
import 'package:true_gym/Features/settings/presentation/view/settings.dart';
import 'package:true_gym/Features/splash_screan/splash_screan.dart';
import 'package:true_gym/initial.dart';

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
      GoRoute(
        path: '/chatScrean',
        builder: (context, state) => const ChatScrean(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
