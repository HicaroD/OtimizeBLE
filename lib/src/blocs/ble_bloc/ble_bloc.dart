import 'package:bloc/bloc.dart';
import 'package:otimize_ble/src/ble_manager/ble_connector.dart';
import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';
import 'package:otimize_ble/src/ble_manager/device.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_states.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final BleScanner bleScanner;
  final BleDeviceConnector bleDeviceConnector;

  BleBloc({
    required this.bleScanner,
    required this.bleDeviceConnector,
  }) : super(BleInitialState()) {
    on<BleStartScanningEvent>((event, emit) async {
      bleScanner.startScan();

      await emit.forEach(
        bleScanner.state,
        onData: (BleScannerState state) =>
            BleScannedDevicesState(scanResult: state),
      );
    });

    on<BleStopScanningEvent>((_, __) async {
      bleScanner.stopScan();
    });

    on<BleConnectToDeviceEvent>((event, emit) async {
      bleDeviceConnector.connect(event.device);

      await emit.forEach(
        bleDeviceConnector.state,
        onData: (Map<String, Device> connectedDevices) =>
            BleConnectedDevicesState(connectedDevices: connectedDevices),
      );
    });
  }
}
