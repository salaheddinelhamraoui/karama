import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karama/features/feeds/presentation/pages/feeds/feeds_page.dart';

import 'core/app_theme.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/temp/bloc/temp_bloc.dart';
import 'features/auth/presentation/pages/login_in/login_page.dart';
import 'features/auth/presentation/pages/pass_settings/pass_settings.dart';
import 'features/auth/presentation/pages/phone_verif/phone_verif_page.dart';
import 'features/auth/presentation/pages/profile_setup/profile_setup_page.dart';
import 'features/auth/presentation/pages/registration/registration_page.dart';
import 'features/auth/presentation/pages/welcome/welcome_page.dart';
import 'package:go_router/go_router.dart';
import './features/feeds/domain/entities/feed.dart';

import 'features/feeds/presentation/bloc/feeds/bloc/feed_bloc.dart';
import 'features/profile/presentation/bloc/bloc/my_feed_bloc.dart';
import 'features/requests/domain/entities/request.dart';
import 'features/requests/presentation/bloc/bloc/tags_bloc.dart';
import 'features/requests/presentation/bloc/editeRequest/bloc/edit_request_bloc.dart';
import 'features/requests/presentation/bloc/request/bloc/request_bloc.dart';
import 'features/requests/presentation/pages/feeds/edit_request_page.dart';
import 'features/requests/presentation/pages/feeds/new_request_page.dart';
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
        BlocProvider(create: (_) => di.sl<TempBloc>()..add(GetTempDataEvent())),
        BlocProvider(create: (_) => di.sl<TagsBloc>()),
        BlocProvider(create: (_) => di.sl<RequestBloc>()),
        BlocProvider(create: (_) => di.sl<FeedBloc>()..add(GetFeedsEvent())),
        BlocProvider(create: (_) => di.sl<MyFeedBloc>()..add(GetMyFeedEvent())),
        BlocProvider(create: (_) => di.sl<EditRequestBloc>()),
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
          GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) =>
                const RegistrationWidget(),
          ),
          GoRoute(
            path: 'verify',
            builder: (BuildContext context, GoRouterState state) =>
                const PhoneVerifWidget(),
          ),
          GoRoute(
            path: 'feeds',
            builder: (BuildContext context, GoRouterState state) =>
                const FeedsPage(),
          ),
          GoRoute(
            path: 'passSettings',
            builder: (BuildContext context, GoRouterState state) =>
                const PassSettingWidget(),
          ),
          GoRoute(
            path: 'profileSetup',
            builder: (BuildContext context, GoRouterState state) =>
                const ProfileSetupWidget(),
          ),
          GoRoute(
            path: 'newRequest',
            builder: (BuildContext context, GoRouterState state) =>
                const NewRequestPage(),
          ),
          GoRoute(
            path: 'editRequest',
            builder: (BuildContext context, GoRouterState state) {
              Feed feed = state.extra as Feed;
              return EditRequestPage(feed: feed);
            },
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

class TagRequestBlocsBloc {}
