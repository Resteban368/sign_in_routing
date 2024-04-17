import 'package:go_router/go_router.dart';

import '../data/repositories/user_session_repository.dart';
import 'common/not_found_page.dart';
import 'home/home_page.dart';
import 'password_recovery/password_recovery_page.dart';
import 'profile/profile_page.dart';
import 'sign_in/sign_in_page.dart';

class AppRouter {
  factory AppRouter() => _instance;

  AppRouter._();

  static final AppRouter _instance = AppRouter._();

  late final router = GoRouter(
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      final isSigningIn = state.matchedLocation == '/signin' ||
          state.matchedLocation == '/recover-password';

      if (!UserSessionRepository().isSignedIn) {
        print('ENTRO AQUI');
        print('state.uri ${state.uri}');
        print("isSigningIn $isSigningIn");
        return isSigningIn ? null : '/signin?redirect=${state.uri}';
      }

      if (isSigningIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        path: '/',
      ),
      GoRoute(
        name: PasswordRecoveryPage.routeName,
        builder: (context, state) => PasswordRecoveryPage(
          defaultEmail: state.extra as String? ?? '',
        ),
        path: '/recover-password',
      ),
      GoRoute(
        name: ProfilePage.routeName,
        builder: (context, state) => ProfilePage(),
        path: '/profile',
      ),
      GoRoute(
        name: SignInPage.routeName,
        builder: (context, state) => SignInPage(
          redirect: state.uri.queryParameters['redirect'],
        ),
        path: '/signin',
      ),
    ],
  );
}
