import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleDeviceConnector {
  void connect(BluetoothDevice device) async {
    await device.connect();
  }

  void disconnect(BluetoothDevice device) async {
    await device.disconnect();
  }
}
