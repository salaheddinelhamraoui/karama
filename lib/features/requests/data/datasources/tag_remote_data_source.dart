import 'dart:convert';

import 'package:karama/features/requests/domain/entities/tag.dart';
import 'package:karama/features/requests/domain/entities/tag_category.dart';

import '../../../../core/error/exceptions.dart';
import '../models/tag_category_model.dart';
import 'package:http/http.dart' as http;

abstract class TagRemoteDataSource {
  Future<List<TagCategoryModel>> getTags(String token);
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";

class TagRemoteDataSourceImpl implements TagRemoteDataSource {
  final http.Client client;

  TagRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TagCategoryModel>> getTags(token) async {
    try {
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

        for (var i = 0; i < jsonObject['data'].length; i++) {
          List<Tag> tags = [];

          for (var j = 0;
              j < jsonObject['data'][i]['_tags_of_category'].length;
              j++) {
            Tag tag = Tag(
                id: jsonObject['data'][i]['_tags_of_category'][j]['id'],
                tagName: jsonObject['data'][i]['_tags_of_category'][j]['name']);
            tags.add(tag);
          }

          TagCategoryModel tagCat = TagCategoryModel(
              id: jsonObject['data'][i]['id'],
              name: jsonObject['data'][i]['name'],
              type: jsonObject['data'][i]['category_type'],
              tags: tags);

          tagsCat.add(tagCat);
        }
        return tagsCat;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      print(100);
      throw ServerException();
    }
  }
}
