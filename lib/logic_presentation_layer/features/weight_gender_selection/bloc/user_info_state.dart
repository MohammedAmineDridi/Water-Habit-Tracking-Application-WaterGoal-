part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}

class GenderChangedValue extends UserInfoState{
  final String gender;
  GenderChangedValue({required this.gender});
}

class WeightUnitChangedValue extends UserInfoState{
  final String weightUnit;
  WeightUnitChangedValue({required this.weightUnit});
}