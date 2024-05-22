part of 'cards_screen_bloc.dart';

class CardsScreenBlocState extends Equatable {
  final int? numberOfFlippedCards;
  final List<FlipCardModel>? cardsInGame;
  final List<FlipCardModel>? cardsSelected;
  final bool? successPairInCards;
  final bool? errorPairInCards;
  final int? score;
  final int? maxScorePosible;
  final LogTimerModel? logsTimer;
  final int? secondsInTimer;

  const CardsScreenBlocState(
      {this.numberOfFlippedCards = 0,
      this.cardsInGame,
      this.cardsSelected,
      this.successPairInCards,
      this.errorPairInCards,
      this.score = 0,
      this.maxScorePosible = 0,
      this.logsTimer,
      this.secondsInTimer,
      });

  CardsScreenBlocState copyWith({
    int? numberOfFlippedCards,
    List<FlipCardModel>? cardsInGame,
    List<FlipCardModel>? cardsSelected,
    bool? successPairInCards,
    bool? errorPairInCards,
    int? score,
    int? maxScorePosible,
    LogTimerModel? logsTimer,
    int? secondsInTimer,
  }) {
    return CardsScreenBlocState(
      numberOfFlippedCards: numberOfFlippedCards ?? this.numberOfFlippedCards,
      cardsInGame: cardsInGame ?? this.cardsInGame,
      cardsSelected: cardsSelected ?? this.cardsSelected,
      successPairInCards: successPairInCards ?? this.successPairInCards,
      errorPairInCards: errorPairInCards ?? this.errorPairInCards,
      score : score ?? this.score,
      maxScorePosible : maxScorePosible ?? this.maxScorePosible,
      logsTimer : logsTimer ?? this.logsTimer,
      secondsInTimer : secondsInTimer ?? this.secondsInTimer
    );
  }

  @override
  List<Object?> get props => [
        numberOfFlippedCards,
        cardsInGame,
        cardsSelected,
        successPairInCards,
        errorPairInCards,
        score,
        maxScorePosible,
        logsTimer,
        secondsInTimer
      ];
}
