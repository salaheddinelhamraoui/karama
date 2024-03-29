import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:karama/features/auth/domain/usecases/get_temp_data.dart';
import 'package:karama/features/auth/domain/usecases/get_token.dart';
import 'package:karama/features/auth/domain/usecases/get_verify_state.dart';
import 'package:karama/features/auth/presentation/bloc/delete_account/bloc/delete_account_bloc.dart';
import 'package:karama/features/contacts/domain/usecases/check_contacts.dart';
import 'package:karama/features/requests/domain/usecases/get_tags.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/data/datasources/user_local_data_source.dart';
import 'features/auth/data/datasources/user_remote_data_source.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/delete_user.dart';
import 'features/auth/domain/usecases/edit_profile.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/domain/usecases/log_out.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/setup_user.dart';
import 'features/auth/domain/usecases/signup_user.dart';
import 'features/auth/domain/usecases/submit_onboarding_data.dart';
import 'features/auth/domain/usecases/verify_user.dart';
import 'features/auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/logout/bloc/logout_bloc.dart';
import 'features/auth/presentation/bloc/temp/bloc/temp_bloc.dart';

import 'features/contacts/data/datasources/contact_local_data_source.dart';
import 'features/contacts/data/datasources/contact_remote_data_source.dart';
import 'features/contacts/data/repositories/contact_repository_impl.dart';
import 'features/contacts/domain/repositories/contact_repository.dart';
import 'features/contacts/domain/usecases/get_contacts.dart';
import 'features/contacts/domain/usecases/invite_contact.dart';
import 'features/contacts/presentation/bloc/check_contacts/bloc/check_contacts_bloc.dart';
import 'features/contacts/presentation/bloc/contacts/bloc/contacts_bloc.dart';
import 'features/feeds/data/datasources/feed_remote_data_source.dart';
import 'features/feeds/data/repositories/feed_repository_impl.dart';
import 'features/feeds/domain/repositories/feed_repository.dart';
import 'features/feeds/domain/usecases/get_Feed.dart';
import 'features/feeds/domain/usecases/get_Feed_By_User.dart';
import 'features/feeds/presentation/bloc/feeds/bloc/feed_bloc.dart';
import 'features/friendsRequests/data/datasources/invitations_remote_data_source.dart';
import 'features/friendsRequests/data/repositories/invitation_repository_impl.dart';
import 'features/friendsRequests/domain/repositories/invitation_repository.dart';
import 'features/friendsRequests/domain/usecases/get_invitations.dart';
import 'features/friendsRequests/domain/usecases/invitation_actions.dart';
import 'features/friendsRequests/presentation/bloc/invitations/bloc/invitations_bloc.dart';
import 'features/profile/presentation/bloc/bloc/my_feed_bloc.dart';
import 'features/profile/presentation/bloc/editProfile/bloc/edit_profile_bloc.dart';
import 'features/requests/data/datasources/tag_remote_data_source.dart';
import 'features/requests/data/repositories/request_repository_impl.dart';
import 'features/requests/data/repositories/tag_category_repository_impl.dart';
import 'features/requests/domain/repositories/request_repository.dart';
import 'features/requests/domain/repositories/tag_repository.dart';
import 'features/requests/domain/usecases/edit_request.dart';
import 'features/requests/domain/usecases/post_request.dart';
import 'features/requests/presentation/bloc/bloc/tags_bloc.dart';
import 'features/requests/presentation/bloc/editeRequest/bloc/edit_request_bloc.dart';
import 'features/requests/presentation/bloc/request/bloc/request_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Features - Auth + Temp

// Bloc
  sl.registerFactory(
      () => AuthBloc(loginUser: sl(), getUser: sl(), getToken: sl()));

  sl.registerFactory(
    () => TempBloc(
      signUp: sl(),
      getVerifyUseCase: sl(),
      verifyUser: sl(),
      getTempDataUseCase: sl(),
      submitOnboardingDataUseCase: sl(),
    ),
  );

  sl.registerFactory(() => DeleteAccountBloc(deleteUser: sl()));

  sl.registerFactory(() => LogoutBloc(logOut: sl()));

// Usecases

  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => SetUpUserUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUserUseCase(sl()));
  sl.registerLazySingleton(() => VerifyUserUseCase(sl()));
  sl.registerLazySingleton(() => GetVerifyUseCase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => GetTempDataUseCase(sl()));
  sl.registerLazySingleton(() => SubmitOnboardingDataUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));

// Repository

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl(), localDataSource: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

// -------------------------------------------------------------------------

// Features - Requests

// bloc

  sl.registerFactory(() => TagsBloc(getTags: sl()));
  sl.registerFactory(() => RequestBloc(postRequest: sl()));
  sl.registerFactory(() => EditRequestBloc(editRequest: sl()));

// Usecases
  sl.registerLazySingleton(() => GetTagsUseCase(sl()));
  sl.registerLazySingleton(() => PostRequestUseCase(sl()));
  sl.registerLazySingleton(() => EditRequestUseCase(sl()));

// Repository

  sl.registerLazySingleton<TagRepository>(
      () => TagCategoryRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<RequestRepository>(
      () => RequestRepositoryImpl(remoteDataSource: sl()));

// Datasources
  sl.registerLazySingleton<TagRemoteDataSource>(
      () => TagRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()));

// Features - Feeds

// Bloc
  sl.registerFactory(() => FeedBloc(getFeeds: sl()));

// Usecases

  sl.registerLazySingleton(() => GetFeedsUseCase(sl()));
  sl.registerLazySingleton(() => GetFeedByUserUseCase(sl()));

// Repository

  sl.registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImpl(remoteDataSource: sl()));

// Datasources

  sl.registerLazySingleton<FeedRemoteDataSource>(
      () => FeedRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()));

// -------------------------------------------------------------------------

// Features - Profile

// Bloc

  sl.registerFactory(() => MyFeedBloc(getMyFeed: sl()));
  sl.registerFactory(() => EditProfileBloc(editProfile: sl()));

// Usecases

  sl.registerLazySingleton(() => EditProfileUseCase(sl()));

// Repository

// Datasources

// -------------------------------------------------------------------------

// Features - Contacts

// Bloc

  sl.registerFactory(
      () => ContactsBloc(getContacts: sl(), inviteContact: sl()));
  sl.registerFactory(() => CheckContactsBloc(checkContacts: sl()));

// Usecases

  sl.registerLazySingleton(() => GetContactsUseCase(sl()));
  sl.registerLazySingleton(() => CheckContactsUseCase(sl()));
  sl.registerLazySingleton(() => InviteContactUseCase(sl()));

// Repository

  sl.registerLazySingleton<ContactRepository>(() =>
      ContactRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()));

// Datasources

  sl.registerLazySingleton<ContactLocalDataSource>(
      () => ContactLocalDataSourceImpl());

  sl.registerLazySingleton<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImpl(client: sl(), localDataSource: sl()));

// -------------------------------------------------------------------------

// Features - Invitations

// Bloc

  sl.registerFactory(
      () => InvitationsBloc(getInvitations: sl(), InvitationAction: sl()));

// Usecases

  sl.registerLazySingleton(() => GetInvitationsUseCase(sl()));
  sl.registerLazySingleton(() => InvitationActionUseCase(sl()));

// Repository

  sl.registerLazySingleton<InvitationRepository>(() => InvitationRepositoryImpl(
        remoteDataSource: sl(),
      ));

// Datasources

  sl.registerLazySingleton<InvitationRemoteDataSource>(() =>
      InvitationRemoteDataSourceImpl(client: sl(), sharedPreferences: sl()));

// -------------------------------------------------------------------------

// Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
