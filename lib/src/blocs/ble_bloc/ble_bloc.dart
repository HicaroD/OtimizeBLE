import 'package:bloc/bloc.dart';
import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_states.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final BleScanner bleScanner;

  BleBloc({required this.bleScanner}) : super(BleInitialState()) {
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
  }
}
