import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'core/app_theme.dart';
import 'features/auth/presentation/pages/registration/registration_widget.dart';
import 'features/auth/presentation/pages/welcome/welcome_widget.dart';
import 'package:go_router/go_router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterFlowTheme.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        routes: <GoRoute>[
          // GoRoute(
          //   path: 'page2',
          //   builder: (BuildContext context, GoRouterState state) =>
          //   const Page2Screen(),
          // ),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeWidget(),
      ),
    ],
  );

  static of(BuildContext context) {}
}
