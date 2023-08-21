import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleDeviceConnector {
  // TODO: deal with errors
  void connect(BluetoothDevice device) async {
    try {
      await device.connect();
    } catch (error) {
      rethrow;
    }
  }

  // TODO: deal with errors
  void disconnect(BluetoothDevice device) async {
    await device.disconnect();
  }

  // TODO: bondedDevices does not return me all the currently connected devices
  Future<List<BluetoothDevice>> getAllConnectedDevices() async {
    return FlutterBluePlus.bondedDevices;
  }
}
