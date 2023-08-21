import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';

abstract class BleState {}

class BleInitialState extends BleState {}

class BleLoadingState extends BleState {}

class BleScannedDevicesState extends BleState {
  final BleScannerState scanResult;
  BleScannedDevicesState({required this.scanResult});
}

class BleConnectedDevicesState extends BleState {
  final List<BluetoothDevice> devices;

  BleConnectedDevicesState(this.devices);
}
