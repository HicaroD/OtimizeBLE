import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:otimize_ble/src/ble_manager/sensor.dart';

class BleDeviceConnector {
  final List<Sensor> _connectedDevices = [];
  List<Sensor> get connectedDevices => _connectedDevices;

  void connect(BluetoothDevice device) async {
    try {
      await device.connect();
      List<BluetoothService> services =
          await device.discoverServices(timeout: 30);
      _connectedDevices.add(Sensor(device: device, services: services));
    } catch (error) {
      // TODO: deal with errors
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
