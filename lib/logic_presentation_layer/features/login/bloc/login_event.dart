part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


// -----------------------------------  events for LOGIN page ---------------------------------
class ReverseVisibilityEventLogin extends LoginEvent{}
