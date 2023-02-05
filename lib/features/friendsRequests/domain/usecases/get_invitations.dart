import 'package:dartz/dartz.dart';
import 'package:karama/features/friendsRequests/domain/entities/invitation.dart';

import '../../../../core/error/failure.dart';
import '../repositories/invitation_repository.dart';

class GetInvitationsUseCase {
  final InvitationRepository repository;

  GetInvitationsUseCase(this.repository);

  Future<Either<Failure, List<Invitation>>> call() async {
    return await repository.getInvitations();
  }
}
