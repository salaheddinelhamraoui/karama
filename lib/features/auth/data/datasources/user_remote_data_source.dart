import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> sinIn(String mobileNumber);
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/api:BG09bi8f";

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> sinIn(mobileNumber) async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/registre?auth_phone=" + mobileNumber),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final UserModel decodedJson = json.decode(response.body);
      final UserModel userModel = decodedJson;

      return userModel;
    } else {
      throw ServerException();
    }
  }
}
