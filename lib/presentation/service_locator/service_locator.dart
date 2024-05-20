import 'package:flippy_cards/presentation/state/index.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initServiceLocator(){
  getIt.registerFactory(() => CardsScreenBloc());
  getIt.registerFactory(() => LogScreenBloc());
}