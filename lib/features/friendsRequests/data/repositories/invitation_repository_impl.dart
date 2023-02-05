import 'package:karama/core/error/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:karama/features/friendsRequests/domain/entities/invitation.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../datasources/invitations_remote_data_source.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  final InvitationRemoteDataSource remoteDataSource;

  InvitationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Invitation>>> getInvitations() async {
    try {
      final data = await remoteDataSource.getInvitations();
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> invitationAction(
      Invitation inv, bool status) async {
    try {
      final data = await remoteDataSource.invitationAction(inv, status);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
