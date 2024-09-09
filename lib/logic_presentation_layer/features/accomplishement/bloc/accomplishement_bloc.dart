import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watergoal/data_layer/models/accomplishement.dart';

part 'accomplishement_event.dart';
part 'accomplishement_state.dart';

class AccomplishementBloc extends Bloc<AccomplishementEvent, AccomplishementState> {
  AccomplishementBloc() : super(AccomplishementInitial()) {

    on<AccomplishementEvent>((event, emit) {

      if (event is SelectStartDate){
        emit(StartDateIsSelected(startDateSelected:event.startDate));
      }
      if (event is SelectEndDate){
        emit(EndDateIsSelected(endDateSelected:event.endDate));
      }
      if (event is SelectDateFiltredStats){
        emit(ReceiveDateFiltredStats(accomplishements: event.accomplishements));
      }
      if (event is TriggerAveragePercentage){
        emit(AverageIsTriggered(averagePercentage:event.averagePercentage));
      }

    });
  }
}
