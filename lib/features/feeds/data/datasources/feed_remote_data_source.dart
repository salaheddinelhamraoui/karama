import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/feed.dart';

abstract class FeedRemoteDataSource {
  Future<List<Feed>> getFeeds();
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";
const CACHED_TOKEN = "CACHED_TOKEN";

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  FeedRemoteDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  @override
  Future<List<Feed>> getFeeds() async {
    try {
      final token = await getCachedToken();
      final response = await client.get(
        Uri.parse(BASE_URL + 'api:1HF8-Ljt/feed'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Map<String, dynamic> jsonObject = jsonDecode(response.body);

        print(data.toString());

        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
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
