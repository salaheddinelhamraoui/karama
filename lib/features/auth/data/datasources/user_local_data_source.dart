import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getCachedUser();
  Future<Unit> cacheUser(UserModel userModel);
  Future<String> getCachedToken();
  Future<Unit> cacheToken(String token);
  Future<Unit> cacheMobileNumber(String mobileNumber);
  Future<String> getCachedMobileNumber();
  Future<Unit> cacheVerifyUserState(bool state);
  Future<String> getCachedVerifyUserState();
  Future<Map<String, String>> getTempData();
}

const CACHED_USER = "CACHED_USER";
const CACHED_TOKEN = "CACHED_TOKEN";
const CACHED_MOBILE_NUMBER = "CACHED_MOBILE_NUMBER";
const CACHED_VERIFY_STATE = "CACHED_VERIFY_STATE";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getCachedUser() async {
    final userJson = sharedPreferences.getString(CACHED_USER);
    if (userJson == null) {
      throw EmptyCacheException();
    } else {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel(
        firstName: userMap['firstName'],
        lastName: userMap['lastName'],
        gender: userMap['gender'],
        city: userMap['city'],
        country: userMap['country'],
        mobileNumber: userMap['mobileNumber'],
      );
    }
  }

  @override
  Future<String> getCachedToken() async {
    final token = sharedPreferences.getString(CACHED_TOKEN);
    if (token == null) {
      throw EmptyCacheException();
    } else {
      return token.toString();
    }
  }

  @override
  Future<Unit> cacheUser(UserModel userModel) async {
    sharedPreferences.setString(CACHED_USER, jsonEncode(userModel.toJson()));
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheToken(String token) async {
    sharedPreferences.setString(CACHED_TOKEN, token);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheMobileNumber(String mobileNumber) {
    sharedPreferences.setString(CACHED_MOBILE_NUMBER, mobileNumber);
    return Future.value(unit);
  }

  @override
  Future<String> getCachedMobileNumber() async {
    final mobileNumber = sharedPreferences.getString(CACHED_MOBILE_NUMBER);
    if (mobileNumber == null) {
      throw EmptyCacheException();
    } else {
      return mobileNumber.toString();
    }
  }

  @override
  Future<Unit> cacheVerifyUserState(bool state) async {
    sharedPreferences.setString(CACHED_VERIFY_STATE, state.toString());
    return Future.value(unit);
  }

  @override
  Future<String> getCachedVerifyUserState() async {
    final verifyState = sharedPreferences.getString(CACHED_VERIFY_STATE);
    if (verifyState == null) {
      throw EmptyCacheException();
    } else {
      return verifyState;
    }
  }

  @override
  Future<Map<String, String>> getTempData() async {
    final verifyState = sharedPreferences.getString(CACHED_VERIFY_STATE);
    final token = sharedPreferences.getString(CACHED_TOKEN);
    final mobileNumber = sharedPreferences.getString(CACHED_MOBILE_NUMBER);

    return {
      'mobileNumber': mobileNumber ?? '',
      'token': token ?? '',
      'verifyState': verifyState ?? ''
    };
  }
}
