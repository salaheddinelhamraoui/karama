import 'package:karama/features/contacts/domain/entities/contact.dart';
import 'package:karama/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:karama/features/contacts/domain/repositories/contact_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/contacts.dart';
import '../datasources/contact_local_data_source.dart';
import '../datasources/contact_remote_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource localDataSource;
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CustomContact>>> getContacts() async {
    try {
      List<CustomContact> contacts = await localDataSource.getContacts();
      List<String> cleanContacts = [];

      for (var i = 0; i < contacts.length; i++) {
        cleanContacts.add(contacts[i].contactNumber);
      }

      return Right(contacts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Contacts>> checkContacts(List<String> contacts) async {
    try {
      return Right(await remoteDataSource.checkContacts(contacts));
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> inviteContact(String mobileNumber) async {
    try {
      await remoteDataSource.inviteContact(mobileNumber);
      return Right(unit);
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
