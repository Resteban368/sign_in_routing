import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/user_session_repository.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  static const routeName = 'Profile';

  final _futureUser = UserSessionRepository().user;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) => snapshot.hasData
              ? ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 4,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 80,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              snapshot.data!.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              snapshot.data!.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('Sign out'),
                      onPressed: () async {
                        await UserSessionRepository().signOut();
                        if (context.mounted) {
                          GoRouter.of(context).go('/');
                        }
                      },
                    ),
                  ],
                )
              : snapshot.hasError
                  ? Center(
                      child: Text(snapshot.error.toString()),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
          future: _futureUser,
        ),
      );
}
