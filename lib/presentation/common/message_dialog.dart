import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({required this.content, this.title, super.key});

  final Widget? title;
  final Widget? content;

  @override
  Widget build(BuildContext context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('OK'),
          ),
        ],
        content: content,
        title: title,
      );
}
