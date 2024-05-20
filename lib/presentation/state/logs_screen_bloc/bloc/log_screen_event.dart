part of 'log_screen_bloc.dart';

abstract class LogScreenEvent  {}

class SetLogsEvent extends LogScreenEvent{
  final LogTimerModel? logTimerModel;
  SetLogsEvent({this.logTimerModel});
}