import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        darkTheme: AppTheme().dark,
        routerConfig: AppRouter().router,
        theme: AppTheme().light,
        //themeMode: ThemeMode.dark,
        title: 'Sign in routing',
      );
}
