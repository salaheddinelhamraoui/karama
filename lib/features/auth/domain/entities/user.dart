import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final String city;
  final String country;
  final String mobileNumber;
  final String uid;
  final String? avatar;

  const User(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.city,
      required this.country,
      required this.mobileNumber,
      required this.uid,
      this.avatar});

  @override
  List<Object?> get props =>
      [firstName, lastName, gender, city, country, avatar];
}
