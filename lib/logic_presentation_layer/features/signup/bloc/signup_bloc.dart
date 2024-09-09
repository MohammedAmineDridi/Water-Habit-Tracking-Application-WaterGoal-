import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/helpers.dart';

part 'signup_event.dart';
part 'signup_state.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {

  bool visibilitySignUpVar = true;

  SignupBloc() : super(SignupInitial()) {

    on<SignupEvent>((event, emit) {
     
      // ------------------------- SIGNUP events -------------------------
      if (event is ReverseVisibilityEventSignUp){
          visibilitySignUpVar = !visibilitySignUpVar;
          emit(VisibilityChangedStateSignUp(visibilitySignUpVariable: visibilitySignUpVar));
      }
      if (event is EmailVerificationEventSignUp){
          emit(EmailIsMatchedStateSignUp(emailIsValid: isValidEmail(event.email)));
          //emit(VisibilityChangedStateSignUp(visibilitySignUpVariable: visibilitySignUpVar));
      }

      
    });
  }
}
