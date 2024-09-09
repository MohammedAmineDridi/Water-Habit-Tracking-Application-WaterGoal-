import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  bool visibilityLoginVar = true;
  //bool visibilitySignUpVar = true;

  LoginBloc() : super(LoginInitial()) {

    on<LoginEvent>((event, emit) {
      // ------------------------- LOGIN events -------------------------
      if (event is ReverseVisibilityEventLogin){
          visibilityLoginVar = !visibilityLoginVar;
          emit(VisibilityChangedStateLogin(visibilityLoginVariable: visibilityLoginVar));
      }
      
    });
  }
}
