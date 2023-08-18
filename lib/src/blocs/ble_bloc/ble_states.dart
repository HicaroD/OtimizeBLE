import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';

abstract class BleState {}

class BleInitialState extends BleState {}

class BleScannedDevicesState extends BleState {
  final BleScannerState scanResult;
  BleScannedDevicesState({required this.scanResult});
}
