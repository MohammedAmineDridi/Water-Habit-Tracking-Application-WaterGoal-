import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stayhydrated_event.dart';
part 'stayhydrated_state.dart';

class StayhydratedBloc extends Bloc<StayhydratedEvent, StayhydratedState> {
  double waterpercentage = 0;
  StayhydratedBloc() : super(StayhydratedInitial()) {
      on<StayhydratedEvent>((event, emit) {
      if (event is PercentageUpdateEvent){
          emit(PercentageIsChangedState(waterpercentage:event.waterpercentage));
      }
      if (event is UpdatePercentageCompleted){
          emit(PercentageCompletedTextChangedState(waterpercentage:event.waterpercentage));
      }
    });
  }
}
