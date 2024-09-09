import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dailygoal_event.dart';
part 'dailygoal_state.dart';

class DailygoalBloc extends Bloc<DailygoalEvent, DailygoalState> {
  String unitSelected = "";
  DailygoalBloc() : super(DailygoalInitial()) {
    on<DailygoalEvent>((event, emit) {
      if (event is SelectGoaltUnitInfo){
          emit(GoalUnitChangedValue(unitSelected:event.unitSelected));
      }
    });
  }
}
