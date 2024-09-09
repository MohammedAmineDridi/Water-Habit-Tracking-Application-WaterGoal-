part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoEvent {}

class SelectGenderEventUserInfo extends UserInfoEvent{
  final String selectedGender;
  SelectGenderEventUserInfo({required this.selectedGender});
}


class SelectWeightUnitEventUserInfo extends UserInfoEvent{
  final String weightUnit;
  SelectWeightUnitEventUserInfo({required this.weightUnit});
}

