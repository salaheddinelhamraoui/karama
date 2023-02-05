import 'package:dartz/dartz.dart';
import 'package:karama/features/friendsRequests/domain/entities/invitation.dart';

import '../../../../core/error/failure.dart';
import '../repositories/invitation_repository.dart';

class InvitationActionUseCase {
  final InvitationRepository repository;

  InvitationActionUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Invitation inv, bool status) async {
    return await repository.invitationAction(inv, status);
  }
}
