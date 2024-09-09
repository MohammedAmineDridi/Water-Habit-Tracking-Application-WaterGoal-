part of 'dailygoal_bloc.dart';

@immutable
sealed class DailygoalEvent {}

class SelectGoaltUnitInfo extends DailygoalEvent{
  final String unitSelected;
  SelectGoaltUnitInfo({required this.unitSelected});
}
