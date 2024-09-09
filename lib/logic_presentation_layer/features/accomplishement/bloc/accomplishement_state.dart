part of 'accomplishement_bloc.dart';

@immutable
sealed class AccomplishementState {}

final class AccomplishementInitial extends AccomplishementState {}

class StartDateIsSelected extends AccomplishementState{
  final String startDateSelected;
  StartDateIsSelected({required this.startDateSelected});
}

class EndDateIsSelected extends AccomplishementState{
  final String endDateSelected;
  EndDateIsSelected({required this.endDateSelected});
}


class ReceiveDateFiltredStats extends AccomplishementState{
  final List<Accomplishement> accomplishements;
  ReceiveDateFiltredStats({required this.accomplishements});
}

class AverageIsTriggered extends AccomplishementState{
  final int averagePercentage;
  AverageIsTriggered({required this.averagePercentage});
}