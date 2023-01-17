import 'failure.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Please try again later.';
    case UnauthorizedFailure:
      return 'Unauthorized';
    case OfflineFailure:
      return 'Please Check your Internet Connection';
    case InvalidCredentialsFailure:
      return 'Invalid Credentials !';
    case NotInvitedFailure:
      return 'Phone Number Not Invited Or Already Exist';
    case PhoneVerificationFailure:
      return 'Unable to verify mobile phone number';
    default:
      return "Unexpected Error, Please try again later";
  }
}
