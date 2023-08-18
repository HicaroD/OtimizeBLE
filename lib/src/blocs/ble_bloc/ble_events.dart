import 'package:otimize_ble/src/ble_manager/device.dart';

abstract class BleEvent {}

class BleStartScanningEvent extends BleEvent {}

class BleStopScanningEvent extends BleEvent {}

class BleConnectToDeviceEvent extends BleEvent {
  final Device device;

  BleConnectToDeviceEvent(this.device);
}
