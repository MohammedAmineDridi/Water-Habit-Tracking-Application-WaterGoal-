

part of 'accomplishement_bloc.dart';

@immutable

sealed class AccomplishementEvent {}

class SelectStartDate extends AccomplishementEvent{
  final String startDate;
  SelectStartDate({required this.startDate});
}

class SelectEndDate extends AccomplishementEvent{
  final String endDate;
  SelectEndDate({required this.endDate});
}

class SelectDateFiltredStats extends AccomplishementEvent{
  final List<Accomplishement> accomplishements;
  SelectDateFiltredStats({required this.accomplishements});
}

class TriggerAveragePercentage extends AccomplishementEvent{
  final int averagePercentage;
  TriggerAveragePercentage({required this.averagePercentage});
}

