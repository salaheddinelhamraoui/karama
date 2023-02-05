import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/friendsRequests/domain/entities/invitation.dart';

abstract class InvitationRepository {
  Future<Either<Failure, List<Invitation>>> getInvitations();
  Future<Either<Failure, Unit>> invitationAction(Invitation inv, bool status);
}
