import '../../extensions.dart';
import '../models/user_session.dart';

class UserSessionRepository {
  factory UserSessionRepository() => _instance;

  UserSessionRepository._();

  static final _instance = UserSessionRepository._();

  bool get isSignedIn => _mockUserSession != null;

  Future<UserSession?> get user async => _mockUserSession;

  UserSession? _mockUserSession;

  Future<void> recoverPasswordForEmail(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
  }

  Future<void> signInWithEmail(
    String email, {
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!email.isValidEmail) {
      throw Exception('Invalid e-mail.');
    }

    if (email.isEmpty) {
      throw Exception('Invalid password.');
    }

    _mockUserSession = UserSession(
      email: email,
      name: 'John Smith',
    );
  }

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _mockUserSession = null;
  }
}
