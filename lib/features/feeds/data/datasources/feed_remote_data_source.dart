import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../requests/domain/entities/tag.dart';
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
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        List<Feed> feeds = [];

        for (var i = 0; i < jsonObject['data']['result'].length; i++) {
          List<Tag> tags = [];
          for (var j = 0;
              j < jsonObject['data']['result'][i]['tags'].length;
              j++) {
            Tag tag = Tag(
                id: jsonObject['data']['result'][i]['tags'][j]['id'],
                tagName: jsonObject['data']['result'][i]['tags'][j]['name']);
            tags.add(tag);
          }

          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
              jsonObject['data']['result'][i]['created_at']);

          print(DateFormat.yMd().format(dateTime));

          Feed feed = Feed(
            id: jsonObject['data']['result'][i]['id'],
            title: jsonObject['data']['result'][i]['title'],
            area: jsonObject['data']['result'][i]['area'],
            avatar: jsonObject['data']['result'][i]['avatar']['url'],
            createdDate: dateTime,
            description: jsonObject['data']['result'][i]['description'],
            firstName: jsonObject['data']['result'][i]['first_name'],
            lastName: jsonObject['data']['result'][i]['last_name'],
            pereference: jsonObject['data']['result'][i]['pereference'],
            phone: jsonObject['data']['result'][i]['phone'],
            products: jsonObject['data']['result'][i]['products'].toString(),
            services: jsonObject['data']['result'][i]['services'].toString(),
            tags: tags,
            userId: jsonObject['data']['result'][i]['user_id'],
          );

          feeds.add(feed);
        }

        return feeds;
      } else {
        throw ServerException();
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
