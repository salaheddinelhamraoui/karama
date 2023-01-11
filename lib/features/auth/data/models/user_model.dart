import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required String firstName,
      required String lastName,
      required String gender,
      required String city,
      required String country,
      required String mobileNumber,
      String? avatar})
      : super(
            firstName: firstName,
            lastName: lastName,
            gender: gender,
            city: city,
            country: country,
            mobileNumber: mobileNumber);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        city: json['city'],
        country: json['country'],
        avatar: json['avatar'],
        mobileNumber: json['mobileNumber']);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'city': city,
      'country': country,
      'avatar': avatar,
      'mobileNumber': mobileNumber
    };
  }
}
