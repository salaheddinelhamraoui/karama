import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';

abstract class SettingsRemoteDataSource {
  Future<Unit> delete();
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";
const CACHED_TOKEN = "CACHED_TOKEN";

class SettingsDataSourceImpl implements SettingsRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  SettingsDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  @override
  Future<Unit> delete() async {
    try {
      final token = await getCachedToken();
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

  Future<String> getCachedToken() async {
    final token = sharedPreferences.getString(CACHED_TOKEN);
    if (token == null) {
      throw EmptyCacheException();
    } else {
      return token.toString();
    }
  }
}
