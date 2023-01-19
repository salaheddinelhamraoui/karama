import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:karama/core/error/exceptions.dart';
import 'package:karama/features/auth/data/datasources/user_local_data_source.dart';

import '../../domain/entities/contact.dart';

abstract class ContactRemoteDataSource {
  Future<List<CustomContact>> checkContacts(List<String> contacts);
  Future<Unit> inviteContact(String mobileNumber);
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";
const CACHED_TOKEN = "CACHED_TOKEN";

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final http.Client client;
  final UserLocalDataSource localDataSource;

  ContactRemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<List<CustomContact>> checkContacts(List<String> contacts) async {
    try {
      final token = await localDataSource.getCachedToken();

      final String contactList = jsonEncode(contacts);

      final Map<String, dynamic> body = {
        'contacts': contacts,
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
        List<CustomContact> mobileNumbers = [];
        for (var i = 0; i < jsonObject['data']['result'].length; i++) {
          CustomContact contact = CustomContact(
              contactName: jsonObject['data']['result'][i]['first_name'] +
                  ' ' +
                  jsonObject['data']['result'][i]['last_name'],
              contactNumber: jsonObject['data']['result'][i]['phone'],
              invited: true,
              avatar: jsonObject['data']['result'][i]['avatar']['url']);
          mobileNumbers.add(contact);
        }

        return mobileNumbers;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<Unit> inviteContact(String mobileNumber) async {
    try {
      final token = await localDataSource.getCachedToken();

      final Map<String, dynamic> body = {
        'to_phone': mobileNumber,
        'token': token,
      };

      final response = await client.post(
        Uri.parse(BASE_URL + 'api:-WXXXyTu/invitation'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
