import 'dart:convert';

import 'package:karama/features/requests/domain/entities/tag.dart';
import 'package:karama/features/requests/domain/entities/tag_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/request.dart';
import '../models/tag_category_model.dart';
import 'package:http/http.dart' as http;

abstract class TagRemoteDataSource {
  Future<List<TagCategoryModel>> getTags();
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";
const CACHED_TOKEN = "CACHED_TOKEN";

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  TagRemoteDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  @override
  Future<List<TagCategoryModel>> getTags() async {
    try {
      final token = await getCachedToken();

      final response = await client.get(
        Uri.parse(BASE_URL + 'api:XDi8QT5O/mixed_category_tags'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Map<String, dynamic> jsonObject = jsonDecode(response.body);
        List<TagCategoryModel> tagsCat = [];

        for (var i = 0; i < jsonObject['data']['result'].length; i++) {
          List<Tag> tags = [];

          for (var j = 0;
              j < jsonObject['data']['result'][i]['_tags_of_category'].length;
              j++) {
            Tag tag = Tag(
                id: jsonObject['data']['result'][i]['_tags_of_category'][j]
                    ['id'],
                tagName: jsonObject['data']['result'][i]['_tags_of_category'][j]
                    ['name']);
            tags.add(tag);
          }

          TagCategoryModel tagCat = TagCategoryModel(
              id: jsonObject['data']['result'][i]['id'],
              name: jsonObject['data']['result'][i]['name'],
              type: jsonObject['data']['result'][i]['category_type'],
              tags: tags);

          tagsCat.add(tagCat);
        }
        return tagsCat;
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

  Future<String> postRequest(Request req) async {
    try {
      final token = req.token;
      final Map<String, String> body = {
        'title': req.title,
        'description': req.description,
        'products': req.products,
        'services': req.services,
        'pereference': req.pereference,
        'tags': req.tags.toString(),
        'area': req.area,
        'token': req.token,
      };

      final response = await client.post(
        Uri.parse(BASE_URL + "api:Ik6DU6PW/create_request"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        return Future.value();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
    }

    return '';
  }
}
