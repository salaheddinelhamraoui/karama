import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_in/login_page.dart';
import 'features/auth/presentation/pages/registration/registration_page.dart';
import 'features/auth/presentation/pages/welcome/welcome_page.dart';
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
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()..add(getUserEvent())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        routes: <GoRoute>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginWidget(),
          ),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const WelcomeWidget(),
      ),
    ],
  );

  static of(BuildContext context) {}
}
