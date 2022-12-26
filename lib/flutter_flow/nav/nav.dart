// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:page_transition/page_transition.dart';
// import '../flutter_flow_theme.dart';

// import '../../index.dart';
// import '../../main.dart';
// import '../lat_lng.dart';
// import '../place.dart';
// import 'serialization_util.dart';

// export 'package:go_router/go_router.dart';
// export 'serialization_util.dart';

// const kTransitionInfoKey = '__transition_info__';

// class AppStateNotifier extends ChangeNotifier {
//   bool showSplashImage = true;

//   void stopShowingSplashImage() {
//     showSplashImage = false;
//     notifyListeners();
//   }
// }

// GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
//       initialLocation: '/',
//       debugLogDiagnostics: true,
//       refreshListenable: appStateNotifier,
//       errorBuilder: (context, _) => IndexWidget(),
//       routes: [
//         FFRoute(
//           name: '_initialize',
//           path: '/',
//           builder: (context, _) => IndexWidget(),
//           routes: [
//             FFRoute(
//               name: 'Splash',
//               path: 'splash',
//               builder: (context, params) => SplashWidget(),
//             ),
//             FFRoute(
//               name: 'ProfileSetup',
//               path: 'profileSetup',
//               builder: (context, params) => ProfileSetupWidget(),
//             ),
//             FFRoute(
//               name: 'RegistrationReward2',
//               path: 'registrationReward2',
//               builder: (context, params) => RegistrationReward2Widget(),
//             ),
//             FFRoute(
//               name: 'RegistrationReward',
//               path: 'registrationReward',
//               builder: (context, params) => RegistrationRewardWidget(),
//             ),
//             FFRoute(
//               name: 'DO_EMPLOYMENTCopy',
//               path: 'dOEMPLOYMENTCopy',
//               builder: (context, params) => DOEMPLOYMENTCopyWidget(),
//             ),
//             FFRoute(
//               name: 'UI_A07-NEWSERVICESETUP3_3',
//               path: 'uiA07Newservicesetup33',
//               builder: (context, params) => UiA07Newservicesetup33Widget(),
//             ),
//             FFRoute(
//               name: 'UI_A06-NEWSERVICESETUP2_3',
//               path: 'uiA06Newservicesetup23',
//               builder: (context, params) => UiA06Newservicesetup23Widget(),
//             ),
//             FFRoute(
//               name: 'DO_EMPLOYMENTCopyCopy',
//               path: 'dOEMPLOYMENTCopyCopy',
//               builder: (context, params) => DOEMPLOYMENTCopyCopyWidget(),
//             ),
//             FFRoute(
//               name: 'REQNOMINATION-UI_A04X',
//               path: 'reqnominationUiA04x',
//               builder: (context, params) => ReqnominationUiA04xWidget(),
//             ),
//             FFRoute(
//               name: 'UI_A07-NEWSERVICESETUP3_3Copy',
//               path: 'uIA07NEWSERVICESETUP33Copy',
//               builder: (context, params) => UIA07NEWSERVICESETUP33CopyWidget(),
//             ),
//             FFRoute(
//               name: 'UI_DO02-PROSETUP2_3-OFFERSUMMARY',
//               path: 'uiDo02Prosetup23Offersummary',
//               builder: (context, params) =>
//                   UiDo02Prosetup23OffersummaryWidget(),
//             ),
//             FFRoute(
//               name: 'Welcome',
//               path: 'welcome',
//               builder: (context, params) => WelcomeWidget(),
//             ),
//             FFRoute(
//               name: 'Registration',
//               path: 'registration',
//               builder: (context, params) => RegistrationWidget(),
//             ),
//             FFRoute(
//               name: 'PassSetting',
//               path: 'passSetting',
//               builder: (context, params) => PassSettingWidget(),
//             ),
//             FFRoute(
//               name: 'PhoneVerif',
//               path: 'phoneVerif',
//               builder: (context, params) => PhoneVerifWidget(),
//             ),
//             FFRoute(
//               name: 'UI_A04X-REQNOMINATION',
//               path: 'uiA04xReqnomination',
//               builder: (context, params) => UiA04xReqnominationWidget(),
//             ),
//             FFRoute(
//               name: 'UI_A04B-NEW',
//               path: 'uiA04bNew',
//               builder: (context, params) => UiA04bNewWidget(),
//             ),
//             FFRoute(
//               name: 'UI_A06-NEWSERVICESETUP2_3Copy',
//               path: 'uIA06NEWSERVICESETUP23Copy',
//               builder: (context, params) => UIA06NEWSERVICESETUP23CopyWidget(),
//             ),
//             FFRoute(
//               name: 'UI_CO00-MYPROFILECopy',
//               path: 'uICO00MYPROFILECopy',
//               builder: (context, params) => UICO00MYPROFILECopyWidget(),
//             ),
//             FFRoute(
//               name: 'UI_OF01_MyOffer',
//               path: 'uIOF01MyOffer',
//               builder: (context, params) => UIOF01MyOfferWidget(),
//             ),
//             FFRoute(
//               name: 'UI_OF00_NewEditOffer',
//               path: 'uIOF00NewEditOffer',
//               builder: (context, params) => UIOF00NewEditOfferWidget(),
//             ),
//             FFRoute(
//               name: 'UI_CO00-MYPROFILE',
//               path: 'uiCo00Myprofile',
//               builder: (context, params) => UiCo00MyprofileWidget(),
//             ),
//             FFRoute(
//               name: 'UI_OF02_Cotact_ViewOffer',
//               path: 'uIOF02CotactViewOffer',
//               builder: (context, params) => UIOF02CotactViewOfferWidget(),
//             ),
//             FFRoute(
//               name: 'UI_RE01_MyRequestReceived',
//               path: 'uIRE01MyRequestReceived',
//               builder: (context, params) => UIRE01MyRequestReceivedWidget(),
//             ),
//             FFRoute(
//               name: 'UI_RE00_NewEditRequest',
//               path: 'uIRE00NewEditRequest',
//               builder: (context, params) => UIRE00NewEditRequestWidget(),
//             ),
//             FFRoute(
//               name: 'UI_RE10_ContactViewReq',
//               path: 'uIRE10ContactViewReq',
//               builder: (context, params) => UIRE10ContactViewReqWidget(),
//             ),
//             FFRoute(
//               name: 'UI_RE110_ViewIntroSuggestion',
//               path: 'uIRE110ViewIntroSuggestion',
//               builder: (context, params) => UIRE110ViewIntroSuggestionWidget(),
//             ),
//             FFRoute(
//               name: 'UI_RE112_MyIntroReqPending',
//               path: 'uIRE112MyIntroReqPending',
//               builder: (context, params) => UIRE112MyIntroReqPendingWidget(),
//             ),
//             FFRoute(
//               name: 'UI_CO00B_MyProfile_Requests',
//               path: 'uICO00BMyProfileRequests',
//               builder: (context, params) => UICO00BMyProfileRequestsWidget(),
//             ),
//             FFRoute(
//               name: 'UI_CO02_ContactList',
//               path: 'uICO02ContactList',
//               builder: (context, params) => UICO02ContactListWidget(),
//             ),
//             FFRoute(
//               name: 'UI_RE10_Contact_View_Pinned',
//               path: 'uIRE10ContactViewPinned',
//               builder: (context, params) => UIRE10ContactViewPinnedWidget(),
//             ),
//             FFRoute(
//               name: 'UI_TG00_Tags_Management',
//               path: 'uITG00TagsManagement',
//               builder: (context, params) => UITG00TagsManagementWidget(),
//             ),
//             FFRoute(
//               name: 'Index',
//               path: 'index',
//               builder: (context, params) => IndexWidget(),
//             )
//           ].map((r) => r.toRoute(appStateNotifier)).toList(),
//         ).toRoute(appStateNotifier),
//       ],
//       urlPathStrategy: UrlPathStrategy.path,
//     );

// extension NavParamExtensions on Map<String, String?> {
//   Map<String, String> get withoutNulls => Map.fromEntries(
//         entries
//             .where((e) => e.value != null)
//             .map((e) => MapEntry(e.key, e.value!)),
//       );
// }

// extension _GoRouterStateExtensions on GoRouterState {
//   Map<String, dynamic> get extraMap =>
//       extra != null ? extra as Map<String, dynamic> : {};
//   Map<String, dynamic> get allParams => <String, dynamic>{}
//     ..addAll(params)
//     ..addAll(queryParams)
//     ..addAll(extraMap);
//   TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
//       ? extraMap[kTransitionInfoKey] as TransitionInfo
//       : TransitionInfo.appDefault();
// }

// class FFParameters {
//   FFParameters(this.state, [this.asyncParams = const {}]);

//   final GoRouterState state;
//   final Map<String, Future<dynamic> Function(String)> asyncParams;

//   Map<String, dynamic> futureParamValues = {};

//   // Parameters are empty if the params map is empty or if the only parameter
//   // present is the special extra parameter reserved for the transition info.
//   bool get isEmpty =>
//       state.allParams.isEmpty ||
//       (state.extraMap.length == 1 &&
//           state.extraMap.containsKey(kTransitionInfoKey));
//   bool isAsyncParam(MapEntry<String, dynamic> param) =>
//       asyncParams.containsKey(param.key) && param.value is String;
//   bool get hasFutures => state.allParams.entries.any(isAsyncParam);
//   Future<bool> completeFutures() => Future.wait(
//         state.allParams.entries.where(isAsyncParam).map(
//           (param) async {
//             final doc = await asyncParams[param.key]!(param.value)
//                 .onError((_, __) => null);
//             if (doc != null) {
//               futureParamValues[param.key] = doc;
//               return true;
//             }
//             return false;
//           },
//         ),
//       ).onError((_, __) => [false]).then((v) => v.every((e) => e));

//   dynamic getParam<T>(
//     String paramName,
//     ParamType type, [
//     bool isList = false,
//   ]) {
//     if (futureParamValues.containsKey(paramName)) {
//       return futureParamValues[paramName];
//     }
//     if (!state.allParams.containsKey(paramName)) {
//       return null;
//     }
//     final param = state.allParams[paramName];
//     // Got parameter from `extras`, so just directly return it.
//     if (param is! String) {
//       return param;
//     }
//     // Return serialized value.
//     return deserializeParam<T>(
//       param,
//       type,
//       isList,
//     );
//   }
// }

// class FFRoute {
//   const FFRoute({
//     required this.name,
//     required this.path,
//     required this.builder,
//     this.requireAuth = false,
//     this.asyncParams = const {},
//     this.routes = const [],
//   });

//   final String name;
//   final String path;
//   final bool requireAuth;
//   final Map<String, Future<dynamic> Function(String)> asyncParams;
//   final Widget Function(BuildContext, FFParameters) builder;
//   final List<GoRoute> routes;

//   GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
//         name: name,
//         path: path,
//         pageBuilder: (context, state) {
//           final ffParams = FFParameters(state, asyncParams);
//           final page = ffParams.hasFutures
//               ? FutureBuilder(
//                   future: ffParams.completeFutures(),
//                   builder: (context, _) => builder(context, ffParams),
//                 )
//               : builder(context, ffParams);
//           final child = page;

//           final transitionInfo = state.transitionInfo;
//           return transitionInfo.hasTransition
//               ? CustomTransitionPage(
//                   key: state.pageKey,
//                   child: child,
//                   transitionDuration: transitionInfo.duration,
//                   transitionsBuilder: PageTransition(
//                     type: transitionInfo.transitionType,
//                     duration: transitionInfo.duration,
//                     reverseDuration: transitionInfo.duration,
//                     alignment: transitionInfo.alignment,
//                     child: child,
//                   ).transitionsBuilder,
//                 )
//               : MaterialPage(key: state.pageKey, child: child);
//         },
//         routes: routes,
//       );
// }

// class TransitionInfo {
//   const TransitionInfo({
//     required this.hasTransition,
//     this.transitionType = PageTransitionType.fade,
//     this.duration = const Duration(milliseconds: 300),
//     this.alignment,
//   });

//   final bool hasTransition;
//   final PageTransitionType transitionType;
//   final Duration duration;
//   final Alignment? alignment;

//   static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
// }
