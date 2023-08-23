import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BleEvent {}

class BleStartScanningEvent extends BleEvent {}

class BleStopScanningEvent extends BleEvent {}

class BleConnectToDeviceEvent extends BleEvent {
  final BluetoothDevice device;

  BleConnectToDeviceEvent(this.device);
}

class BleConnectedDevicesEvent extends BleEvent {}

class BleStartEvaluationEvent extends BleEvent {}
