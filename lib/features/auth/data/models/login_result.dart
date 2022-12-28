class LoginResponse {
  final bool status;
  final Result? result;
  LoginResponse({this.result, required this.status});
}

class Result {
  final String token;
  final List<LocalUser>? user;
  Result({required this.token, this.user});
}

class LocalUser {
  final UserData userData;
  LocalUser({required this.userData});
}

class UserData {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String city;
  final String country;
  final String avatar;
  final int createdAt;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.city,
    required this.country,
    required this.avatar,
    required this.createdAt,
  });
}
