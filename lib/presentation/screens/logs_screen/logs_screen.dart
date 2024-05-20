import 'package:flippy_cards/core/constants/app_strings.dart';
import 'package:flippy_cards/domain/models/index.dart';
import 'package:flippy_cards/presentation/service_locator/service_locator.dart';
import 'package:flippy_cards/presentation/state/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => getIt<LogScreenBloc>(),
        child: Builder(builder: (context) {
          return const _BodyScreen();
        }),
      ),
    );
  }
}

class _BodyScreen extends StatefulWidget {
  const _BodyScreen();

  @override
  State<_BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<_BodyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _loadLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        final LogTimerModel? logs = context.select((LogScreenBloc value) => value.state.logTimerModel);

        if(logs == null){
          return const Center(
            child: Text(AppStrings.labelNoLogs),
          );
        }

        else{
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black12,
            ),
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            itemCount: logs.list!.length,
            itemBuilder: (BuildContext context, int index) {

              final ListElement? log = logs.list?[index];

              return  PhysicalShape(
                color: Colors.white,
          elevation: 5,
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
                child: ListTile(
    
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  trailing: const Icon(Icons.date_range),
                  title: Text(DateFormat("dd/MM/yyyy").format(log!.dateTime!)) ,
                  subtitle: Text("${(int.parse(log.timer!) / 1000).toStringAsFixed(1)} segundos"),
                ),
              );
            },
          );
        }

      }
    );
  }

  Future<void> _loadLogs() async {
    await SharedPreferences.getInstance().then((value) {
      final logs = value.getString("logs");
      if (logs != null) {
        context
            .read<LogScreenBloc>()
            .add(SetLogsEvent(logTimerModel: LogTimerModel.fromRawJson(logs)));
      }
    });
  }
}
