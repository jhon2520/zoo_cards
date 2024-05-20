import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flippy_cards/domain/models/index.dart';

part 'cards_screen_event.dart';
part 'cards_screen_state.dart';

class CardsScreenBloc extends Bloc<CardsScreenEvent, CardsScreenState> {
  CardsScreenBloc() : super(const CardsScreenState()) {
    on<SetNumberOfFlippedCardsEvent>((event, emit) {
      if (event.cardIsFront == false) {
        emit(state.copyWith(
            numberOfFlippedCards: state.numberOfFlippedCards! - 1));
      } else {
        emit(state.copyWith(
            numberOfFlippedCards: state.numberOfFlippedCards! + 1));
      }
    });
    on<SetCardsIsSelectedEvent>((event, emit) {
      final FlipCardModel? cardSelected = state.cardsInGame
          ?.firstWhere((element) => element.id == event.idCard);

      final List<FlipCardModel>? currentsCardsSelected = state.cardsSelected;
      List<FlipCardModel>? newCurrentCardsSelected = [];

      if (cardSelected?.isFront == true) {
        newCurrentCardsSelected = currentsCardsSelected
            ?.where((element) => element.id != event.idCard)
            .toList();
      } else {
        newCurrentCardsSelected = [...state.cardsSelected ?? [], cardSelected!];
      }

      emit(state.copyWith(cardsSelected: newCurrentCardsSelected));


    });
    on<SetInitCardsForGammingEvent>((event, emit) {

      final List<FlipCardModel>  cardsToBeSet = FlipCardModel.getCards();

      emit(state.copyWith(
        cardsInGame: cardsToBeSet, maxScorePosible:  (cardsToBeSet.length / 2).round() ));
    });
    on<ResetCardsEvent>((event, emit) async {

      final List<FlipCardModel>  cardsToBeSet = FlipCardModel.getCards();

      emit(state.copyWith(
        cardsInGame: []));
      await Future.delayed(const Duration(milliseconds: 200));
      emit(state.copyWith(
        cardsInGame: cardsToBeSet,
        numberOfFlippedCards: 0,
        cardsSelected: [],
        successPairInCards: false,
        errorPairInCards: false,
        score: 0,
        maxScorePosible:  (cardsToBeSet.length / 2).round() 
        ));

    });
    on<ResetSuccesEvent>((event, emit) {
      emit(state.copyWith(successPairInCards: false));
    });
    on<ResetErrorEvent>((event, emit) {
      emit(state.copyWith(errorPairInCards: false));
    });

    on<SetAllCardsEnableEvent>((event, emit) {
      final newCardsInGame =
          state.cardsInGame?.map((e) => e.copyWith(isEnable: true)).toList();
      emit(state.copyWith(cardsInGame: newCardsInGame));
    });

    on<SetCardsStateIsFrontEvent>((event, emit) {
      final List<FlipCardModel>? currentCards = state.cardsInGame;
      final List<FlipCardModel>? newCards = currentCards?.map((e) {
        if (e.id == event.id) {
          return e.copyWith(isFront: !e.isFront!);
        }
        return e;
      }).toList();
      emit(state.copyWith(cardsInGame: newCards));
    });

    on<SetCardsNoFlippedDisableEvent>((event, emit) {
      final int counterFlippedCards = state.numberOfFlippedCards ?? 0;
      if (counterFlippedCards >= 2) {
        final List<FlipCardModel>? currentCards = state.cardsInGame;
        final List<FlipCardModel>? newCards = currentCards?.map((e) {
          if (e.isFront == false) {
            return e.copyWith(isEnable: false);
          }
          return e;
        }).toList();

        emit(state.copyWith(cardsInGame: newCards));
      }
    });
    on<SetCardsAreEqualEvent>((event, emit) {
      if (state.numberOfFlippedCards! < 2) {
        return;
      }

      final List<FlipCardModel>? cardsSelected = state.cardsSelected;
      final String? firstCardName = cardsSelected?[0].name;
      final String? secondCardName = cardsSelected?[1].name;
      final String? firstCardid = cardsSelected?[0].id;
      final String? secondCardid = cardsSelected?[1].id;

      if (firstCardName == null || secondCardName == null) {
        return;
      }

      if (firstCardName == secondCardName) {
        final List<FlipCardModel>? newCardsInGame = state.cardsInGame?.map((e) {
          if (e.id == firstCardid || e.id == secondCardid) {
            return e.copyWith(
              isVisible: false,
              isEnable: false,
            );
          } else {
            return e.copyWith(isEnable: true);
          }
        }).toList();

        emit(state.copyWith(
            cardsInGame: newCardsInGame,
            numberOfFlippedCards: 0,
            cardsSelected: [],
            successPairInCards: true,
            score: state.score! + 1
            ));
      } else {
        emit(state.copyWith(errorPairInCards: true));
      }
    });
  }
}
