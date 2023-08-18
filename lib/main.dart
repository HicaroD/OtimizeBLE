import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/ui/buttons.dart';
import 'package:otimize_ble/src/ui/scanned_device_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final ble = FlutterReactiveBle();
  final bleScanner = BleScanner(ble: ble);

  runApp(
    BlocProvider(
      create: (_) => BleBloc(bleScanner: bleScanner),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OtimizeBLE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OtimizeBLE(title: 'OtimizeBLE'),
    );
  }
}

class OtimizeBLE extends StatefulWidget {
  const OtimizeBLE({super.key, required this.title});

  final String title;

  @override
  State<OtimizeBLE> createState() => _OtimizeBLEState();
}

class _OtimizeBLEState extends State<OtimizeBLE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Buttons(),
            ScannedDeviceList(),
          ],
        ),
      ),
    );
  }
}
