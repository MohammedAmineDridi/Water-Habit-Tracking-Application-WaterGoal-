part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


// -----------------------------------  states for LOGIN page ---------------------------------
class VisibilityChangedStateLogin extends LoginState{

  final bool visibilityLoginVariable;
  VisibilityChangedStateLogin({required this.visibilityLoginVariable});

}