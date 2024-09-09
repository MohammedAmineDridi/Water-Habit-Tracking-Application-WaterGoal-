part of 'dailygoal_bloc.dart';

@immutable
sealed class DailygoalState {}

final class DailygoalInitial extends DailygoalState {}

class GoalUnitChangedValue extends DailygoalState{
  final String unitSelected;
  GoalUnitChangedValue({required this.unitSelected});
}