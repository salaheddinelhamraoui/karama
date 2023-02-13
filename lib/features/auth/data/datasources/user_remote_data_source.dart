import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:karama/features/auth/data/datasources/user_local_data_source.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user.dart';
import '../models/login_result.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> sinIn(String mobileNumber, String password);
  Future<Unit> signUp(String mobileNumber);
  Future<String> verifyUser(String pinCode, String mobileNumber);
  Future<String> submitOnboardingData(
      String avatar,
      String firstName,
      String lastName,
      String gender,
      String country,
      String state,
      String city,
      String token,
      String mobileNumber,
      String password);
  Future<Unit> editProfile(User user);
  Future<Unit> refreshToken();
  Future<Unit> deleteUser();
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/api:BG09bi8f";
const CACHED_TOKEN = "CACHED_TOKEN";

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final UserLocalDataSource localDataSource;

  UserRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<UserModel> sinIn(mobileNumber, password) async {
    try {
      final Map<String, String> body = {
        'auth_phone': mobileNumber,
        'password': password,
      };

      final response = await client.post(
        Uri.parse(BASE_URL + "/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        String token = jsonObject['data']['result']['token'].toString();

        localDataSource.cacheToken(token);

        Map<String, dynamic> userData = jsonObject['data']['result']['user'];
        String uid = jsonObject['data']['uid'];

        String city = userData['city'] ?? '';

        UserModel user = UserModel(
            firstName: userData['first_name'],
            lastName: userData['last_name'],
            gender: userData['gender'],
            city: city,
            country: userData['country'],
            avatar: userData['avatar']['url'],
            mobileNumber: userData['phone'],
            uid: uid);

        return user;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<Unit> signUp(mobileNumber) async {
    try {
      final Map<String, String> body = {
        'auth_phone': mobileNumber,
      };

      final response = await client.post(
        Uri.parse(BASE_URL + "/registre"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        localDataSource.cacheMobileNumber(mobileNumber);
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  Future<String> verifyUser(pinCode, mobileNumber) async {
    try {
      if (mobileNumber != null) {
        final Map<String, String> body = {
          'phone': mobileNumber,
          'pin': pinCode,
        };

        final response = await client.post(
          Uri.parse(BASE_URL + "/pin_verification"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );

        final data = jsonDecode(response.body);
        Map<String, dynamic> jsonObject = jsonDecode(response.body);

        if (response.statusCode == 200 &&
            jsonObject['data']['status'] == true) {
          var token = jsonObject['data']['result'];

          localDataSource.cacheToken(token);

          localDataSource.cacheVerifyUserState(true);

          return token;
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<String> submitOnboardingData(
      String avatar,
      String firstName,
      String lastName,
      String gender,
      String country,
      String state,
      String city,
      String token,
      String mobileNumber,
      String password) async {
    try {
      final Map<String, String> body = {
        'first_name': firstName,
        'last_name': lastName,
        'gender': gender,
        'city': city,
        'state': state,
        'country': country,
        'image': 'data:image/png;base64,' + avatar,
        'phone': mobileNumber,
        'password': password,
        'token': token
      };

      final response = await client.post(
        Uri.parse("https://xyxm-adm5-et4s.n7.xano.io/api:VYETVf0h/onboarding"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        return 'done';
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Unit> editProfile(User user) async {
    try {
      String token = await localDataSource.getCachedToken();

      final Map<String, dynamic> body = {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'gender': user.gender,
        'city': user.city,
        'state': "",
        'country': user.country,
        'img': user.avatar,
        'phone': user.mobileNumber,
        'token': token
      };

      final response = await client.post(
        Uri.parse(
            "https://xyxm-adm5-et4s.n7.xano.io/api:VYETVf0h/edit_onboarding"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['data']['status'] == true) {
        Map<String, dynamic> userData = data['data']['result'];

        UserModel user = UserModel(
            firstName: userData['first_name'],
            lastName: userData['last_name'],
            gender: userData['gender'],
            city: userData['city'],
            country: userData['country'],
            avatar: userData['avatar']['url'],
            mobileNumber: userData['phone'],
            uid: userData['uid']);

        localDataSource.cacheUser(user);
      } else {
        throw ServerException();
      }

      return unit;
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<Unit> refreshToken() async {
    try {
      String token = await localDataSource.getCachedToken();
      User user = await localDataSource.getCachedUser();

      final Map<String, dynamic> body = {
        'token': token,
        'phone': user.mobileNumber
      };

      final response = await client.post(
        Uri.parse(
            "https://xyxm-adm5-et4s.n7.xano.io/api:BG09bi8f/refresh_token"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['data']['status'] == true) {
        String token = data['data']['result'];

        localDataSource.cacheToken(token);

        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteUser() async {
    try {
      String token = await localDataSource.getCachedToken();
      final Map<String, dynamic> body = {'token': token, 'status': false};

      final response = await client.post(
        Uri.parse(BASE_URL + 'api:BG09bi8f:v1/user_status'),
        headers: {
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw e;
    }
  }
}
