import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {

  String genderSelected = "";
  String weightUnit = "";
  UserInfoBloc() : super(UserInfoInitial()) {
    on<UserInfoEvent>((event, emit) {
      if (event is SelectGenderEventUserInfo){
          emit(GenderChangedValue(gender:event.selectedGender));
      }
      if (event is SelectWeightUnitEventUserInfo){
        emit(WeightUnitChangedValue(weightUnit: event.weightUnit));
      }
    });
  }
}
