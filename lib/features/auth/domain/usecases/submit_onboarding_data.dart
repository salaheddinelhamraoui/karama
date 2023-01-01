import 'package:dartz/dartz.dart';
import 'package:karama/core/error/failure.dart';
import 'package:karama/features/auth/domain/entities/user.dart';
import 'package:karama/features/auth/domain/repositories/user_repository.dart';

class SubmitOnboardingDataUseCase {
  final UserRepository repository;

  SubmitOnboardingDataUseCase(this.repository);

  Future<Either<Failure, String>> call(
      String avatar,
      String firstName,
      String lastName,
      String gender,
      String country,
      String state,
      String city,
      String token,
      String mobileNumber,
      String password) async {
    return await repository.submitOnboardingData(avatar, firstName, lastName,
        gender, country, state, city, token, mobileNumber, password);
  }
}
