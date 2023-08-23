import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: () {
            context.read<BleBloc>().add(BleStartScanningEvent());
          },
          icon: const Icon(Icons.search),
          label: const Text("Scan"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<BleBloc>().add(BleStopScanningEvent());
          },
          icon: const Icon(Icons.stop),
          label: const Text("Stop"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<BleBloc>().add(BleStartEvaluationEvent());
          },
          icon: const Icon(Icons.start),
          label: const Text("Start"),
        ),
      ],
    );
  }
}
