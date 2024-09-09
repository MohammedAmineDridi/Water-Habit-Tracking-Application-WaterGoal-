part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

// -----------------------------------  events for SIGNUP page ---------------------------------
class EmailVerificationEventSignUp extends SignupEvent{
  final String email;
  EmailVerificationEventSignUp({required this.email});
}
class ReverseVisibilityEventSignUp extends SignupEvent{}
