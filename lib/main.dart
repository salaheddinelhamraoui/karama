import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karama/features/feeds/presentation/pages/feeds/feeds_page.dart';

import 'core/app_theme.dart';
import 'core/util/snackbar_message.dart';
import 'features/auth/domain/entities/user.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/logout/bloc/logout_bloc.dart';
import 'features/auth/presentation/bloc/temp/bloc/temp_bloc.dart';
import 'features/auth/presentation/pages/login_in/login_page.dart';
import 'features/auth/presentation/pages/pass_settings/pass_settings.dart';
import 'features/auth/presentation/pages/phone_verif/phone_verif_page.dart';
import 'features/auth/presentation/pages/profile_setup/profile_setup_page.dart';
import 'features/auth/presentation/pages/registration/registration_page.dart';
import 'features/auth/presentation/pages/welcome/welcome_page.dart';
import 'package:go_router/go_router.dart';
import './features/feeds/domain/entities/feed.dart';

import 'features/contacts/presentation/bloc/check_contacts/bloc/check_contacts_bloc.dart';
import 'features/contacts/presentation/bloc/contacts/bloc/contacts_bloc.dart';
import 'features/feeds/presentation/bloc/feeds/bloc/feed_bloc.dart';
import 'features/friendsRequests/presentation/bloc/invitations/bloc/invitations_bloc.dart';
import 'features/friendsRequests/presentation/pages/feeds/friends _page.dart';
import 'features/profile/presentation/bloc/bloc/my_feed_bloc.dart';
import 'features/profile/presentation/bloc/editProfile/bloc/edit_profile_bloc.dart';
import 'features/profile/presentation/pages/edit_profile/edit_profile.dart';
import 'features/requests/domain/entities/request.dart';
import 'features/requests/presentation/bloc/bloc/tags_bloc.dart';
import 'features/requests/presentation/bloc/editeRequest/bloc/edit_request_bloc.dart';
import 'features/requests/presentation/bloc/request/bloc/request_bloc.dart';
import 'features/requests/presentation/pages/feeds/edit_request_page.dart';
import 'features/requests/presentation/pages/feeds/new_request_page.dart';
import 'features/settings/presentation/bloc/delete_account/bloc/delete_account_bloc.dart';
import 'features/settings/presentation/pages/privacy_policy/privacy_policy.dart';
import 'features/settings/presentation/pages/settings/settings.dart';
import 'features/settings/presentation/pages/terms_of_use/terms_of_use.dart';
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
        BlocProvider(create: (_) => di.sl<FeedBloc>()),
        BlocProvider(create: (_) => di.sl<MyFeedBloc>()..add(GetMyFeedEvent())),
        BlocProvider(create: (_) => di.sl<EditRequestBloc>()),
        BlocProvider(create: (_) => di.sl<EditProfileBloc>()),
        BlocProvider(
            create: (_) => di.sl<ContactsBloc>()..add(GetContactsEvent())),
        BlocProvider(create: (_) => di.sl<CheckContactsBloc>()),
        BlocProvider(create: (_) => di.sl<LogoutBloc>()),
        BlocProvider(create: (_) => di.sl<DeleteAccountBloc>()),
        BlocProvider(
            create: (_) =>
                di.sl<InvitationsBloc>()..add(GetInvitationsEvent())),
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
                BlocListener<CheckContactsBloc, CheckContactsState>(
              listener: (context, state) {
                if (state is CheckContactsInitial) {
                } else {
                  BlocProvider.of<FeedBloc>(context).add(GetFeedsEvent());
                }
              },
              child: BlocListener<ContactsBloc, ContactsState>(
                listener: (context, state) {
                  if (state is ContactsLoadedState) {
                    BlocProvider.of<CheckContactsBloc>(context)
                        .add(PostCheckContactsEvent(contacts: state.contacts));
                  } else if (state is ErrorLoadingContactsState) {
                    SnackBarMessage().showErrorSnackBar(
                        message: state.message, context: context);
                  }
                },
                child: BlocListener<LogoutBloc, LogoutState>(
                  listener: (context, state) {
                    if (state is LoggingErrorState) {
                      SnackBarMessage().showErrorSnackBar(
                          message: state.message, context: context);
                    } else if (state is LoggedOutState) {
                      context.go('/login');
                    }
                  },
                  child: FeedsPage(),
                ),
              ),
            ),
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
          GoRoute(
            path: 'editProfile',
            builder: (BuildContext context, GoRouterState state) {
              User user = state.extra as User;
              return EditProfilePage(user: user);
            },
          ),
          GoRoute(
            path: 'invitations',
            builder: (BuildContext context, GoRouterState state) {
              return FriendsPage();
            },
          ),
          GoRoute(
            path: 'termsOfUse',
            builder: (BuildContext context, GoRouterState state) {
              return TermsOfUsePage();
            },
          ),
          GoRoute(
            path: 'privacyPolicy',
            builder: (BuildContext context, GoRouterState state) {
              return PrivacyPolicyPage();
            },
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return SettingsScreen();
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
