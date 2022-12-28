import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getCachedUser();
  Future<Unit> cacheUser(UserModel userModel);
}

const CACHED_USER = "CACHED_USER";

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
      );
    }
  }

  @override
  Future<Unit> cacheUser(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(CACHED_USER, jsonEncode(userModel.toJson()));
    return Future.value(unit);
  }
}
