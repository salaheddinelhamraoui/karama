import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:karama/features/auth/data/datasources/user_local_data_source.dart';
import '../../../../core/error/exceptions.dart';
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

      Map<String, dynamic> userData =
          jsonObject['data']['result']['user'][0]['user_data'];

      UserModel user = UserModel(
        firstName: userData['first_name'],
        lastName: userData['last_name'],
        gender: userData['gender'],
        city: userData['city'],
        country: userData['country'],
        avatar: userData[''],
      );

      return user;
    } else {
      throw ServerException();
    }
  }

  Future<Unit> signUp(mobileNumber) async {
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
  }

  Future<String> verifyUser(pinCode, mobileNumber) async {
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

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
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
    final Map<String, String> body = {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'city': city,
      'state': state,
      'country': country,
      'avatar': avatar,
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
  }
}
