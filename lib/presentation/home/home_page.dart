import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = 'Home';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async =>
                  GoRouter.of(context).pushNamed(ProfilePage.routeName),
              icon: const Icon(Icons.person),
            ),
          ],
          title: const Text('Home'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Item #${index + 1}'),
            ),
          ),
          itemCount: 30,
        ),
      );
}
