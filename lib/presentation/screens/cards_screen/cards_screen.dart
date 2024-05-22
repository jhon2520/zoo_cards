// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flippy_cards/core/constants/app_strings.dart';
import 'package:flippy_cards/domain/models/index.dart';
import 'package:flippy_cards/presentation/screens/logs_screen/logs_screen.dart';
import 'package:flippy_cards/presentation/service_locator/service_locator.dart';
import 'package:flippy_cards/presentation/state/cards_screen_bloc/cards_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CardsScreens extends StatelessWidget {
  const CardsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            getIt<CardsScreenBloc>()..add(SetInitCardsForGammingEvent()),
        child: Builder(builder: (context) {
          return const _BodyCardsScreen();
        }),
      ),
    );
  }
}

class _BodyCardsScreen extends StatefulWidget {
  const _BodyCardsScreen();

  @override
  State<_BodyCardsScreen> createState() => _BodyCardsScreenState();
}

class _BodyCardsScreenState extends State<_BodyCardsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) async {
      await _loadPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: BlocConsumer<CardsScreenBloc, CardsScreenBlocState>(
          listener: (context, state) {
            if (state.successPairInCards == true) {
              context.read<CardsScreenBloc>().add(ResetSuccesEvent());
            }
            if (state.errorPairInCards == true &&
                state.numberOfFlippedCards == 0) {
              context.read<CardsScreenBloc>().add(SetAllCardsEnableEvent());
            }
          },
          builder: (context, state) {
            final List<FlipCardModel>? cards = context
                .select((CardsScreenBloc bloc) => bloc.state.cardsInGame);
            final int? score =
                context.select((CardsScreenBloc bloc) => bloc.state.score);

            if (cards == null || cards.isEmpty) {
              return const CircularProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: Container(
                      width: double.infinity,
                      height: 600,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          final card = cards[index];

                          return _FlipCards(
                            cardModel: card,
                          );
                        },
                      )),
                ),
                _ScoreWidget(score: score)
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _loadPreferences() async {
    await SharedPreferences.getInstance().then((value) {
      if (value.getString("logs") != null) {
        context.read<CardsScreenBloc>().add(SetLogsTimerEvents(
            logTimerModel:
                LogTimerModel.fromRawJson(value.getString("logs")!)));
      }
    });
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({
    required this.score,
  });

  final int? score;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsScreenBloc, CardsScreenBlocState>(
      listener: (context, state) async {
        if (state.maxScorePosible == state.score) {
          await _showModalWinner(context).then((value) {
            if (value == true) {
              context.read<CardsScreenBloc>().add(ResetCardsEvent());
            }
          });
        }
      },
      listenWhen: (previous, current) => previous.score != current.score,
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                Text(
                  "${AppStrings.labelScore} : $score",
                  style: const TextStyle(fontSize: 18),
                ),
                const Spacer(),
                const _TimerWidget(),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.amber[800],
                  child: IconButton(
                      onPressed: () {
                        context.read<CardsScreenBloc>().add(ResetCardsEvent());
                      },
                      icon: const Icon(Icons.replay_outlined)),
                )
              ],
            ));
      },
    );
  }

  Future<bool?> _showModalWinner(BuildContext context) async {
    return await showDialog<bool?>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        titleTextStyle: const TextStyle(fontSize: 18, color: Colors.black87),
        title: const Text(AppStrings.labelTitleWinner),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(AppStrings.labelReiniciarPartida),
            SizedBox(
              height: 5,
            ),
            Image(image: AssetImage("assets/ponque.jpg")),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        actions: [
          FilledButton.tonal(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogsScreen(),
                    ));
              },
              child: const Text(AppStrings.labelScores)),
          FilledButton.tonal(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(AppStrings.labelOk)),
        ],
      ),
    );
  }
}

class _FlipCards extends StatefulWidget {
  final FlipCardModel cardModel;

  const _FlipCards({
    required this.cardModel,
  });

  @override
  State<_FlipCards> createState() => _FlipCardsState();
}

class _FlipCardsState extends State<_FlipCards> {
  late FlipCardController _controller;
  bool? setMethods = false;

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 500));
      _controller.toggleCard();
      await Future.delayed(const Duration(seconds: 3));
      _controller.toggleCard();
      await Future.delayed(const Duration(seconds: 1));
      setMethods = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Builder(builder: (context) {
        if (widget.cardModel.isVisible == false) {
          return _SuccessCard(
            cardModel: widget.cardModel,
          );
        }

        return IgnorePointer(
          ignoring: widget.cardModel.isEnable == true ? false : true,
          child: BlocConsumer<CardsScreenBloc, CardsScreenBlocState>(
            listener: (context, state) async {
              if(state.errorPairInCards == true && widget.cardModel.isFront == true){
                await Future.delayed(const Duration(milliseconds: 2));
              context.read<CardsScreenBloc>().add(SetAllCardsEnableEvent(value: false));
              context.read<CardsScreenBloc>().add(ResetErrorEvent());
                await Future.delayed(const Duration(milliseconds: 300));
                _controller.toggleCard();
                await Future.delayed(const Duration(milliseconds: 300));
              context.read<CardsScreenBloc>().add(SetAllCardsEnableEvent(value: true));

              }
            },
            builder: (context, state) {
              return FlipCard(
                  autoFlipDuration: const Duration(milliseconds: 300),
                  onFlipDone: (isFront) {
                    if (setMethods == true) {
                      _increaseCounterFlippedCards(_controller);
                      _setCardsIsSelected(widget.cardModel.id!);
                      _setCardsStateIsFront(widget.cardModel.id!);
                      _setCardsNoFLippedDesiable();
                      _setCardsAreEqualEvent();
                    }
                  },
                  controller: _controller,
                  onFlip: () {},
                  side: widget.cardModel.isFront == true
                      ? CardSide.FRONT
                      : CardSide.BACK,
                  front: _FrontCard(
                    cardModel: widget.cardModel,
                  ),
                  back: const _BackCard());
            },
          ),
        );
      }),
    );
  }

  void _increaseCounterFlippedCards(FlipCardController controller) {
    context.read<CardsScreenBloc>().add(
        SetNumberOfFlippedCardsEvent(cardIsFront: !controller.state!.isFront));
  }

  void _setCardsStateIsFront(String id) {
    context.read<CardsScreenBloc>().add(SetCardsStateIsFrontEvent(id: id));
  }

  void _setCardsNoFLippedDesiable() {
    context.read<CardsScreenBloc>().add(SetCardsNoFlippedDisableEvent());
  }

  void _setCardsIsSelected(String id) {
    context.read<CardsScreenBloc>().add(SetCardsIsSelectedEvent(idCard: id));
  }

  void _setCardsAreEqualEvent() {
    context.read<CardsScreenBloc>().add(SetCardsAreEqualEvent());
  }
}

class _SuccessCard extends StatefulWidget {
  final FlipCardModel cardModel;

  const _SuccessCard({required this.cardModel});

  @override
  State<_SuccessCard> createState() => _SuccessCardState();
}

class _SuccessCardState extends State<_SuccessCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Container(
          decoration: _decorationBack(),
          child: Image(
            image: AssetImage(widget.cardModel.path!),
            fit: BoxFit.cover,
          )),
    );
  }

  BoxDecoration _decorationBack() => BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 5, color: Colors.green),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 2),
                spreadRadius: 2)
          ]);
}

class _BackCard extends StatelessWidget {
  const _BackCard();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60,
        height: 60,
        decoration: _decorationBack(),
        child: const Image(image: AssetImage("assets/ponque.jpg")));
  }

  BoxDecoration _decorationBack() => BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 2),
                spreadRadius: 2)
          ]);
}

class _FrontCard extends StatelessWidget {
  final FlipCardModel cardModel;

  const _FrontCard({required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _decorationBack(),
        child: Image(
          image: AssetImage(cardModel.path!),
          fit: BoxFit.cover,
        ));
  }

  BoxDecoration _decorationBack() => BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.cyanAccent, width: 3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(2, 2),
                spreadRadius: 2)
          ]);
}

class _TimerWidget extends StatefulWidget {
  const _TimerWidget();

  @override
  State<_TimerWidget> createState() => __TimerWidgetState();
}

class __TimerWidgetState extends State<_TimerWidget> {
  late StopWatchTimer _stopWatchTimer;

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
    )..onStartTimer();
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardsScreenBloc, CardsScreenBlocState>(
      listener: (context, state) {
        if (state.maxScorePosible == state.score) {
          _stopWatchTimer.onStopTimer();
          _saveTimerInPreferences(
              _stopWatchTimer.rawTime.valueOrNull.toString());
          context.read<CardsScreenBloc>().add(
              SetTimerSecondsEvent(value: _stopWatchTimer.rawTime.valueOrNull));
        }
      },
      listenWhen: (previous, current) => previous.score != current.score,
      builder: (context, state) {
        return StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime =
                StopWatchTimer.getDisplayTime(value!, milliSecond: false);
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                displayTime,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _saveTimerInPreferences(String? timer) async {
    LogTimerModel logTimerModel = LogTimerModel(
        list: [ListElement(dateTime: DateTime.now(), timer: timer)]);
    final prefs = await SharedPreferences.getInstance();

    final String? logs = prefs.getString("logs");
    if (logs != null) {
      final LogTimerModel oldLogTimerModel = LogTimerModel.fromRawJson(logs);
      final newLogs = oldLogTimerModel.copyWith(
          list: [...oldLogTimerModel.list ?? [], ...logTimerModel.list ?? []]);
      await prefs.setString("logs", newLogs.toRawJson());
    } else {
      await prefs.setString("logs", logTimerModel.toRawJson());
    }
  }
}
