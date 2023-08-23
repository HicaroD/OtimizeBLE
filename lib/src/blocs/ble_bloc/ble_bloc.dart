import 'package:bloc/bloc.dart';
import 'package:otimize_ble/src/ble_manager/ble_commands.dart';
import 'package:otimize_ble/src/ble_manager/ble_connector.dart';
import 'package:otimize_ble/src/ble_manager/ble_interactor.dart';
import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_states.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final BleScanner bleScanner;
  final BleDeviceConnector bleDeviceConnector;

  BleBloc({
    required this.bleScanner,
    required this.bleDeviceConnector,
  }) : super(BleInitialState()) {
    // TODO: deal with any error
    on<BleStartScanningEvent>((event, emit) async {
      bleScanner.startScan();

      await emit.forEach(
        bleScanner.state,
        onData: (BleScannerState state) =>
            BleScannedDevicesState(scanResult: state),
      );
    });

    // TODO: deal with any error
    on<BleStopScanningEvent>((_, __) async {
      bleScanner.stopScan();
    });

    // TODO: deal with any error
    on<BleConnectToDeviceEvent>((event, emit) async {
      final device = event.device;
      bleDeviceConnector.connect(device);
    });

    // TODO: deal with any error
    on<BleStartEvaluationEvent>((event, emit) async {
      final bleInteractor = BleInteractor(bleDeviceConnector.connectedDevices);
      bleInteractor.write(BleCommand.StartEvaluation);
    });
  }
}
