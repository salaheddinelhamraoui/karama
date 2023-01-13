import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:karama/core/error/exceptions.dart';
import 'package:karama/features/auth/data/datasources/user_local_data_source.dart';

abstract class ContactRemoteDataSource {
  Future<List<String>> checkContacts(List<String> contacts);
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";
const CACHED_TOKEN = "CACHED_TOKEN";

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final http.Client client;
  final UserLocalDataSource localDataSource;

  ContactRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<String>> checkContacts(List<String> contacts) async {
    try {
      final token = await localDataSource.getCachedToken();

      final String contactList = jsonEncode(contacts);

      final Map<String, dynamic> body = {
        'contacts': contactList,
        'token': token,
      };

      final response = await client.post(
        Uri.parse(BASE_URL + 'api:SzDFJ6x-/check_contact'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        print(33);
        return [];
      } else {
        print(99);
        throw ServerException();
      }
    } catch (e) {
      print(1);
      print(e);
      throw ServerException();
    }
  }
}
