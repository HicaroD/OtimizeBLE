import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleDeviceConnector {
  final _connectedDevices = <String, BluetoothDevice>{};

  final StreamController<BleConnectedDevices> _stateStreamController =
      StreamController.broadcast();

  Stream<BleConnectedDevices> get state => _stateStreamController.stream;

  void connect(BluetoothDevice device) async {
    try {
      await device.connect();
      _connectedDevices.putIfAbsent(device.remoteId.str, () => device);
      _setConnectedDeviceState();
      // TODO: deal with errors
    } catch (error) {
      rethrow;
    }
  }

  void disconnect(BluetoothDevice device) async {
    await device.disconnect();
  }

  void _setConnectedDeviceState() {
    _stateStreamController.add(
      BleConnectedDevices(connectedDevices: _connectedDevices),
    );
  }
}

class BleConnectedDevices {
  const BleConnectedDevices({
    required this.connectedDevices,
  });

  final Map<String, BluetoothDevice> connectedDevices;
}
