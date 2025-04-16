import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/chat/presentation/view/pages/chat_home_page.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:linkify/Features/profile/data/repositories/get_user_posts_repo.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_data/get_user_data_cubit.dart';
import 'package:linkify/Features/profile/presentation/cubit/get_user_posts/get_user_posts_cubit.dart';
import 'package:linkify/core/shared_logic/data/repositories/post_control_repo.dart';
import 'package:linkify/Features/home/presentation/cubit/add_comment/add_comment_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/add_remove_love/add_remove_love_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post_comments/get_post_comments_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post_lovers/get_post_lovers_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_posts/get_posts_cubit.dart';
import 'package:linkify/Features/home/presentation/view/pages/comments_page.dart';
import 'package:linkify/Features/home/presentation/view/pages/loves_page.dart';
import 'package:linkify/Features/navigation_bar/navigation_page.dart';
import 'package:linkify/core/shared_logic/cubit/post_control/post_control_cubit.dart';
import 'package:linkify/Features/posts/presentation/cubit/add_post/add_post_cubit.dart';
import 'package:linkify/Features/posts/presentation/view/add_post_page.dart';
import 'package:linkify/Features/profile/presentation/view/profile.dart';
import 'package:linkify/Features/register/data/repository/auth_repo.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';
import 'package:linkify/Features/register/data/repository/signup_repo.dart';
import 'package:linkify/Features/connectivity/disconnected_page.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/Features/register/presentation/cubit/auth/auth_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/signup/signup_cubit.dart';
import 'package:linkify/Features/register/presentation/cubit/user_data/user_cubit.dart';
import 'package:linkify/Features/register/presentation/view/pages/forgot_password_page.dart';
import 'package:linkify/Features/register/presentation/view/pages/login_page.dart';
import 'package:linkify/Features/register/presentation/view/pages/signup_page.dart';
import 'package:linkify/Features/settings/presentation/view/settings.dart';
import 'package:linkify/Features/splash_screan/splash_screan.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';
import 'package:linkify/initial.dart';

abstract class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: '/',
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
            create: (context) => UserCubit(gitItInstanse<UserDataRepo>()),
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
              create: (context) => UserCubit(gitItInstanse<UserDataRepo>())
                ..getCurrentUserData(),
            ),
            BlocProvider(create: (_) => gitItInstanse<AddPostCubit>()),
            BlocProvider(
              create: (_) => gitItInstanse<GetPostsCubit>()..getAllPosts(),
            ),
            BlocProvider(
              create: (_) => PostControlCubit(gitItInstanse<PostControlRepo>()),
            ),
            BlocProvider(
              create: (_) =>
                  AddRemoveLoveCubit(gitItInstanse<PostControlRepo>()),
            ),
          ],
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/profilePage/:userId',
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) =>
                  GetUserDataCubit(gitItInstanse<UserDataRepo>())
                    ..getUserData(state.pathParameters['userId']!)),
          BlocProvider(
            create: (context) =>
                UserCubit(gitItInstanse<UserDataRepo>())..getCurrentUserData(),
          ),
          BlocProvider(
              create: (context) =>
                  GetUserPostsCubit(gitItInstanse<GetUserPostsRepo>())
                    ..getUserPosts(state.pathParameters['userId']!)),
        ], child: const ProfilePage()),
      ),
      GoRoute(
        path: '/addPost',
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) =>
                  PostControlCubit(gitItInstanse<PostControlRepo>())),
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
      GoRoute(
        path: '/lovesPage/:postTime',
        builder: (context, state) => BlocProvider(
          create: (context) => GetPostLoversCubit(gitItInstanse<GetPostRepo>())
            ..getLoversPost("${state.pathParameters['postTime']}"),
          child: const LovesPage(),
        ),
      ),
      GoRoute(
        path: '/commentsPage/:postTime',
        builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    AddCommentCubit(gitItInstanse<PostControlRepo>()),
              ),
              BlocProvider(
                create: (context) =>
                    GetPostCommentsCubit(gitItInstanse<GetPostRepo>())
                      ..getComments("${state.pathParameters['postTime']}"),
              )
            ],
            child:
                CommentsPage(postTime: "${state.pathParameters['postTime']}")),
      ),
    ],
  );
}
