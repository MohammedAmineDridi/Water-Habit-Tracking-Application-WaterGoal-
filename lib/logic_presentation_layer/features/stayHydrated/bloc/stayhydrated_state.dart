part of 'stayhydrated_bloc.dart';

@immutable
sealed class StayhydratedState {}

final class StayhydratedInitial extends StayhydratedState {}

class PercentageIsChangedState extends StayhydratedState{
  final double waterpercentage;
  PercentageIsChangedState({required this.waterpercentage});
}

class PercentageCompletedTextChangedState extends StayhydratedState{
  final double waterpercentage;
  PercentageCompletedTextChangedState({required this.waterpercentage});
}