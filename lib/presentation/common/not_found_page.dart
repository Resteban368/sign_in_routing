import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('404 Not Found'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Sorry, we couldn't find the page you where looking for.",
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/'),
              child: const Text('Return to home'),
            ),
          ],
        ),
      );
}
