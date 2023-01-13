import 'package:equatable/equatable.dart';

class CustomContact extends Equatable {
  final String contactName;
  final String contactNumber;

  CustomContact({required this.contactName, required this.contactNumber});

  @override
  List<Object?> get props => [contactName, contactNumber];
}
