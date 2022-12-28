import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/login_result.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> sinIn(String mobileNumber, String password);
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/api:BG09bi8f";

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> sinIn(mobileNumber, password) async {
    final Map<String, String> body = {
      'auth_phone': mobileNumber.substring(1),
      'password': password,
    };

    final response = await client.post(
      Uri.parse(BASE_URL + "/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String, dynamic> jsonObject = jsonDecode(response.body);
      String token = jsonObject['data']['result']['token'];
      Map<String, dynamic> userData =
          jsonObject['data']['result']['user'][0]['user_data'];

      print(token.toString());
      print(userData);

      print('---------------------- /n ');

      UserModel user = UserModel(
        firstName: userData['first_name'],
        lastName: userData['last_name'],
        gender: userData['gender'],
        city: userData['city'],
        country: userData['country'],
        avatar: userData[''],
      );
      return user;
    } else {
      throw ServerException();
    }
  }
}
