import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/invitation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class InvitationRemoteDataSource {
  Future<List<Invitation>> getInvitations();
  Future<Unit> invitationAction(Invitation inv, bool status);
}

const BASE_URL = "https://xyxm-adm5-et4s.n7.xano.io/";
const CACHED_TOKEN = "CACHED_TOKEN";

class InvitationRemoteDataSourceImpl implements InvitationRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  InvitationRemoteDataSourceImpl(
      {required this.client, required this.sharedPreferences});

  Future<String> getCachedToken() async {
    final token = sharedPreferences.getString(CACHED_TOKEN);
    if (token == null) {
      throw EmptyCacheException();
    } else {
      return token.toString();
    }
  }

  @override
  Future<List<Invitation>> getInvitations() async {
    try {
      final token = await getCachedToken();
      final Map<String, String> body = {
        'token': token ?? '',
      };
      final response = await client.post(
        Uri.parse(BASE_URL + 'api:oYlhasey/check_for_invitation'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Invitation> invitations = [];
        for (var i = 0; i < data['data'].length; i++) {
          Invitation invitation = Invitation(
            id: data['data'][i]['id'].toString(),
            request_id: data['data'][i]['request_id'].toString(),
            phone: data['data'][i]['phone'].toString(),
            first_name: data['data'][i]['sender']['first_name'].toString(),
            last_name: data['data'][i]['sender']['last_name'].toString(),
            sender_id: data['data'][i]['sender_id'].toString(),
            avatar: data['data'][i]['sender']['avatar']['url'].toString(),
          );
          invitations.add(invitation);
        }
        return invitations;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<Unit> invitationAction(Invitation inv, bool status) async {
    try {
      final token = await getCachedToken();
      final Map<String, dynamic> body = {
        'token': token ?? '',
        'id': inv.id,
        'status': status
      };
      final response = await client.post(
        Uri.parse(BASE_URL + 'api:oYlhasey/accepting_user'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      Map<String, dynamic> jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonObject['data']['status'] == true) {
        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
