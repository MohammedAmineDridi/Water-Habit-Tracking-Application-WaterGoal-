part of 'signup_bloc.dart';


@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}


// -----------------------------------  states for SIGNUP page ---------------------------------
class EmailIsMatchedStateSignUp extends SignupState{
  final bool emailIsValid;
  EmailIsMatchedStateSignUp({required this.emailIsValid});
}

class VisibilityChangedStateSignUp extends SignupState{
  final bool visibilitySignUpVariable;
  VisibilityChangedStateSignUp({required this.visibilitySignUpVariable});

}

