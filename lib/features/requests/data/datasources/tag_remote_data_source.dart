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
    Tag tag = new Tag(id: 1, tagName: 'test tag name');
    TagCategoryModel tagCat = new TagCategoryModel(
        id: 1, name: 'test', type: 'test type', tags: [tag, tag]);

    final response = await client.post(
      Uri.parse(BASE_URL + 'api:XDi8QT5O/mixed_category_tags'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      print(data.toString());

      return [tagCat, tagCat];
    } else {
      throw ServerException();
    }
  }
}
