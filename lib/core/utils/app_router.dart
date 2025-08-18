import 'package:linkify/core/exports/app_router.dart';

abstract class AppRouter {
  static final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
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
                  ..getCurrentUserData()),
            BlocProvider(create: (_) => gitItInstanse<AddPostCubit>()),
            BlocProvider(create: (_) => gitItInstanse<GetPostsCubit>()),
            BlocProvider(
              create: (_) => PostControlCubit(gitItInstanse<PostControlRepo>()),
            ),
            BlocProvider(
              create: (_) =>
                  AddRemoveLoveCubit(gitItInstanse<PostControlRepo>()),
            ),
            BlocProvider(
              create: (_) => AddPostCubit(
                  gitItInstanse<AddPostRepo>(), gitItInstanse<ImageRepo>()),
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
                  GetUserStatusCubit(gitItInstanse<GetUserStatusRepo>())
                    ..userStatus(state.pathParameters['userId']!)),
          BlocProvider(
              create: (context) => FriendsCubit(gitItInstanse<FriendsRepo>())),
          BlocProvider(
              create: (context) =>
                  GetUserDataCubit(gitItInstanse<UserDataRepo>())
                    ..getUserData(state.pathParameters['userId']!)),
          BlocProvider(
              create: (context) =>
                  GetUserPostsCubit(gitItInstanse<GetUserPostsRepo>())
                    ..getUserPosts(state.pathParameters['userId']!)),
        ], child: const ProfilePage()),
      ),
      GoRoute(
        path: '/postPage/:postId',
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => GetPostCubit(gitItInstanse<GetPostRepo>())
                ..getPost(state.pathParameters['postId']!)),
          BlocProvider(
              create: (context) =>
                  PostControlCubit(gitItInstanse<PostControlRepo>())),
        ], child: const PostPage()),
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
      GoRoute(
        path: '/chatPage/:toUserId',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => UserCubit(gitItInstanse<UserDataRepo>())
                ..getUserData(state.pathParameters['toUserId']!),
            ),
            BlocProvider(
              create: (context) => ChatCubit(gitItInstanse<ChatRepo>())
                ..getAllMessages(state.pathParameters['toUserId']!),
            ),
            BlocProvider(
              create: (context) => SendMessageCubit(
                  gitItInstanse<ChatRepo>(), gitItInstanse<ImageRepo>()),
            ),
          ],
          child: ChatPage(toUserId: state.pathParameters['toUserId']!),
        ),
      ),
      GoRoute(
        path: '/settingsPage',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/notificationPage',
        builder: (context, state) => BlocProvider(
          create: (context) =>
              GetNotificationsCubit(gitItInstanse<GetNotificationsRepo>())
                ..loadInitialNotifications(),
          child: const NotificationPage(),
        ),
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
      GoRoute(
          path: AboutUsPage.routeName,
          builder: (context, state) => const AboutUsPage()),
      GoRoute(
          path: HelpPage.routeName,
          builder: (context, state) => const HelpPage()),
    ],
  );
}
