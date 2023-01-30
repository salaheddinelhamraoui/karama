import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../flutter_flow/flutter_flow_util.dart';
import '../../../requests/domain/entities/tag.dart';
import '../../domain/entities/feed.dart';

abstract class FeedRemoteDataSource {
  Future<List<Feed>> getFeeds();
  Future<List<Feed>> getFeedByUser();
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

      final Map<String, String> body = {
        'token': token ?? '',
      };

      final response = await client.post(
        Uri.parse(BASE_URL + 'api:1HF8-Ljt/feeds_contacts'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        final data = jsonDecode(response.body);

        var mergedArray = jsonObject['data']['result'];

        List<Feed> feeds = [];

        for (var i = 0; i < mergedArray.length; i++) {
          List<Tag> tags = [];
          for (var j = 0; j < mergedArray[i]['tags'].length; j++) {
            Tag tag = Tag(
                id: mergedArray[i]['tags'][j]['id'],
                tagName: mergedArray[i]['tags'][j]['name']);
            tags.add(tag);
          }

          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(mergedArray[i]['created_at']);

          Feed feed = Feed(
            id: mergedArray[i]['id'],
            title: mergedArray[i]['title'],
            area: mergedArray[i]['area'],
            avatar: mergedArray[i]['avatar']['url'],
            createdDate: dateTime,
            description: mergedArray[i]['description'],
            firstName: mergedArray[i]['first_name'],
            lastName: mergedArray[i]['last_name'],
            pereference: mergedArray[i]['pereference'],
            phone: mergedArray[i]['phone'],
            products: mergedArray[i]['products'].toString(),
            services: mergedArray[i]['services'].toString(),
            tags: tags,
            userId: mergedArray[i]['user_id'],
            closed: mergedArray[i]['closed'],
          );

          feeds.add(feed);
        }

        return feeds;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
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

  @override
  Future<List<Feed>> getFeedByUser() async {
    try {
      final token = sharedPreferences.getString(CACHED_TOKEN);

      final Map<String, String> body = {
        'token': token ?? '',
      };

      final response = await client.post(
        Uri.parse(BASE_URL + 'api:Ik6DU6PW/request_perUser'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        final data = jsonDecode(response.body);

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

          Feed feed = Feed(
            id: jsonObject['data']['result'][i]['id'],
            title: jsonObject['data']['result'][i]['title'],
            area: jsonObject['data']['result'][i]['area'],
            avatar: '',
            createdDate: dateTime,
            description: jsonObject['data']['result'][i]['description'],
            firstName: '',
            lastName: '',
            pereference: jsonObject['data']['result'][i]['pereference'],
            phone: '',
            products: jsonObject['data']['result'][i]['products'].toString(),
            services: jsonObject['data']['result'][i]['services'].toString(),
            tags: tags,
            userId: jsonObject['data']['result'][i]['user_id'],
            closed: jsonObject['data']['result'][i]['closed'],
          );
          feeds.add(feed);
        }
        return feeds;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
