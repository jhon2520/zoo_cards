part of 'cards_screen_bloc.dart';

class CardsScreenState extends Equatable {
  final int? numberOfFlippedCards;
  final List<FlipCardModel>? cardsInGame;
  final List<FlipCardModel>? cardsSelected;
  final bool? successPairInCards;
  final bool? errorPairInCards;
  final int? score;
  final int? maxScorePosible;

  const CardsScreenState(
      {this.numberOfFlippedCards = 0,
      this.cardsInGame,
      this.cardsSelected,
      this.successPairInCards,
      this.errorPairInCards,
      this.score = 0,
      this.maxScorePosible = 0,
      });

  CardsScreenState copyWith({
    int? numberOfFlippedCards,
    List<FlipCardModel>? cardsInGame,
    List<FlipCardModel>? cardsSelected,
    bool? successPairInCards,
    bool? errorPairInCards,
    int? score,
    int? maxScorePosible,
  }) {
    return CardsScreenState(
      numberOfFlippedCards: numberOfFlippedCards ?? this.numberOfFlippedCards,
      cardsInGame: cardsInGame ?? this.cardsInGame,
      cardsSelected: cardsSelected ?? this.cardsSelected,
      successPairInCards: successPairInCards ?? this.successPairInCards,
      errorPairInCards: errorPairInCards ?? this.errorPairInCards,
      score : score ?? this.score,
      maxScorePosible : maxScorePosible ?? this.maxScorePosible
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
        maxScorePosible
      ];
}
