import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:otimize_ble/src/ble_manager/ble_connector.dart';
import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/ui/buttons.dart';
import 'package:otimize_ble/src/ui/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterBluePlus.turnOn();

  final bleScanner = BleScanner();
  final bleDeviceConnector = BleDeviceConnector();

  runApp(
    BlocProvider(
      create: (_) => BleBloc(
        bleScanner: bleScanner,
        bleDeviceConnector: bleDeviceConnector,
      ),
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
      body: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Buttons(),
            Tabs(),
          ],
        ),
      ),
    );
  }
}
