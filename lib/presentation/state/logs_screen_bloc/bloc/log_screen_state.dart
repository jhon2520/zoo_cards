part of 'log_screen_bloc.dart';

class LogScreenState extends Equatable {

  final LogTimerModel? logTimerModel;

  const LogScreenState({this.logTimerModel});

  LogScreenState copyWith({
    LogTimerModel? logTimerModel,
  }){
    return LogScreenState(logTimerModel: logTimerModel ?? this.logTimerModel);
  }
  
  @override
  List<Object?> get props => [logTimerModel];
}


