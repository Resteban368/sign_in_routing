import 'package:flutter/material.dart';

import '../../data/repositories/user_session_repository.dart';
import '../../extensions.dart';
import '../common/message_dialog.dart';

class PasswordRecoveryPage extends StatefulWidget {
  PasswordRecoveryPage({
    required String defaultEmail,
    super.key,
  }) : emailController = TextEditingController(
          text: defaultEmail,
        );

  static const routeName = 'PasswordRecovery';

  final TextEditingController emailController;

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  var _isRecoveringPassword = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Password Recovery'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: widget.emailController,
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
            Center(
              child: ElevatedButton(
                onPressed: _isRecoveringPassword ? null : _recoverPassword,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isRecoveringPassword)
                      const CircularProgressIndicator.adaptive(),
                    const Text('Recover password'),
                  ],
                ),
              ),
            ),
          ],
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

  Future<void> _recoverPassword() async {
    try {
      setState(() {
        _isRecoveringPassword = true;
      });
      await UserSessionRepository()
          .recoverPasswordForEmail(widget.emailController.text);
      setState(() {
        _isRecoveringPassword = false;
      });
      if (context.mounted) {
        await _showMessage(
          context,
          'A link to reset your password has been sent '
          'to this e-mail.',
        );
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } on Exception catch (e) {
      if (context.mounted) {
        await _showMessage(context, e.toString());
      }
    }
  }
}
