part of 'stayhydrated_bloc.dart';

@immutable
sealed class StayhydratedEvent {}

class PercentageUpdateEvent extends StayhydratedEvent{
  final double waterpercentage;
  PercentageUpdateEvent({required this.waterpercentage});
}

class UpdatePercentageCompleted extends StayhydratedEvent{
  final double waterpercentage;
  UpdatePercentageCompleted({required this.waterpercentage});
}

