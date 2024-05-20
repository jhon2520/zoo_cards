
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flippy_cards/domain/models/index.dart';

part 'log_screen_event.dart';
part 'log_screen_state.dart';

class LogScreenBloc extends Bloc<LogScreenEvent, LogScreenState> {
  LogScreenBloc() : super(const LogScreenState()){

    on<SetLogsEvent>((event, emit) {
      emit(state.copyWith(logTimerModel: event.logTimerModel));
    });
  }


}
