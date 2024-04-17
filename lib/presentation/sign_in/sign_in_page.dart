import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/user_session_repository.dart';
import '../../extensions.dart';
import '../common/message_dialog.dart';
import '../password_recovery/password_recovery_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    this.redirect,
    super.key,
  });

  static const routeName = 'SignIn';

  final String? redirect;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  var _isPasswordObscured = true;
  var _isSigningIn = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Sign in',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'jsmith@example.com',
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value?.isValidEmail ?? false ? null : 'Invalid e-mail',
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: '******',
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordObscured,
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isPasswordObscured,
                  onFieldSubmitted: _isSigningIn ? null : _signIn,
                  textInputAction: TextInputAction.send,
                  validator: (value) => value?.isNotEmpty ?? false
                      ? null
                      : 'This field must not be empty',
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _isSigningIn ? null : _signIn,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isSigningIn)
                          const CircularProgressIndicator.adaptive(),
                        const Text('Sign in'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: TextButton(
                    onPressed: () async => GoRouter.of(context).pushNamed(
                      PasswordRecoveryPage.routeName,
                      extra: _emailController.text,
                    ),
                    child: const Text('Forgot your password?'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _showMessage(BuildContext context, String message) async {
    if (message.isNotEmpty) {
      return showDialog(
        context: context,
        builder: (context) => MessageDialog(
          content: Text(message),
        ),
      );
    }
  }

  Future<void> _signIn([String? value]) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          _isSigningIn = true;
        });
        await UserSessionRepository().signInWithEmail(
          _emailController.text,
          password: _passwordController.text,
        );
        setState(() {
          _isSigningIn = false;
        });
        if (context.mounted) {
          GoRouter.of(context).go(widget.redirect ?? '/');
        }
      } on Exception catch (e) {
        if (context.mounted) {
          await _showMessage(context, e.toString());
        }
      }
    }
  }

  void _togglePasswordObscured() =>
      setState(() => _isPasswordObscured = !_isPasswordObscured);
}
