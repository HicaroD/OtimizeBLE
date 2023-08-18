import 'package:otimize_ble/src/ble_manager/ble_scanner.dart';
import 'package:otimize_ble/src/ble_manager/device.dart';

abstract class BleState {}

class BleInitialState extends BleState {}

class BleScannedDevicesState extends BleState {
  final BleScannerState scanResult;
  BleScannedDevicesState({required this.scanResult});
}

class BleConnectedDevicesState extends BleState {
  final Map<String, Device> connectedDevices;
  BleConnectedDevicesState({required this.connectedDevices});
}
