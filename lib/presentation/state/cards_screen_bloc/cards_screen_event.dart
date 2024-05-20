part of 'cards_screen_bloc.dart';

abstract class CardsScreenEvent {}

class SetNumberOfFlippedCardsEvent extends CardsScreenEvent {
  final bool? cardIsFront;
  SetNumberOfFlippedCardsEvent({required this.cardIsFront});
}

class SetInitCardsForGammingEvent extends CardsScreenEvent {}

class SetCardsStateIsFrontEvent extends CardsScreenEvent {
  final String id;
  SetCardsStateIsFrontEvent({required this.id});
}

class SetCardsNoFlippedDisableEvent extends CardsScreenEvent {}

class SetCardsIsSelectedEvent extends CardsScreenEvent {
  final String idCard;
  SetCardsIsSelectedEvent({required this.idCard});
}

class SetCardsAreEqualEvent extends CardsScreenEvent {}

class ResetSuccesEvent extends CardsScreenEvent {}

class ResetErrorEvent extends CardsScreenEvent {}

class SetAllCardsEnableEvent extends CardsScreenEvent {}

class ResetCardsEvent extends CardsScreenEvent {}

class SetLogsTimerEvents extends CardsScreenEvent {
  final LogTimerModel? logTimerModel;
  SetLogsTimerEvents({this.logTimerModel});
}
class SetTimerSecondsEvent extends CardsScreenEvent{
  final int? value;
  SetTimerSecondsEvent({this.value});
}