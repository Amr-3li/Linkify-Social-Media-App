import 'package:linkify/Features/settings/data/repo/reset_pass_repo.dart';
import 'package:linkify/Features/settings/presentation/cubit/reset_pass/reset_pass_cubit.dart';
import 'package:linkify/Features/settings/presentation/view/pages/language.dart';
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
        path: DisconnectedPage.routeName,
        builder: (context, state) => const DisconnectedPage(),
      ),
      GoRoute(
        path: LoginPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: SignupPage.routeName,
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
        path: ForgotPasswordPage.routeName,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
          child: const ForgotPasswordPage(),
        ),
      ),
      GoRoute(
        path: NavigationPage.routeName,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(gitItInstanse<AuthRepository>()),
            ),
            BlocProvider(
                create: (context) => UserCubit(gitItInstanse<UserDataRepo>())),
            BlocProvider(create: (_) => gitItInstanse<AddPostCubit>()),
            BlocProvider.value(value: gitItInstanse<GetPostsCubit>()),
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
            BlocProvider(
                create: (_) => ResetPassCubit(gitItInstanse<ResetPassRepo>())),
          ],
          child: const NavigationPage(),
        ),
      ),
      GoRoute(
        path: '${ProfilePage.routeName}/:userId',
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
        path: '${PostPage.routeName}/:postId',
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
        path: AddPostPage.routeName,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) =>
                  PostControlCubit(gitItInstanse<PostControlRepo>())),
        ], child: const AddPostPage()),
      ),
      GoRoute(
        path: ChatHomePage.routeName,
        builder: (context, state) => const ChatHomePage(),
      ),
      GoRoute(
        path: '${ChatPage.routeName}/:toUserId',
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
        path: SettingsPage.routeName,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: NotificationPage.routeName,
        builder: (context, state) => BlocProvider.value(
          value: GetNotificationsCubit(gitItInstanse<GetNotificationsRepo>()),
          child: const NotificationPage(),
        ),
      ),
      GoRoute(
        path: '${LovesPage.routeName}/:postTime',
        builder: (context, state) => BlocProvider(
          create: (context) => GetPostLoversCubit(gitItInstanse<GetPostRepo>())
            ..getLoversPost("${state.pathParameters['postTime']}"),
          child: const LovesPage(),
        ),
      ),
      GoRoute(
        path: '${CommentsPage.routeName}/:postTime',
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
      GoRoute(
          path: LanguagePage.routeName,
          builder: (context, state) => const LanguagePage()),
    ],
  );
}
