import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:otimize_ble/src/ble_manager/device.dart';

class BleDeviceConnector {
  final FlutterReactiveBle ble;

  BleDeviceConnector({required this.ble});

  final _deviceConnectionController =
      StreamController<Map<String, Device>>.broadcast();

  Stream<Map<String, Device>> get state => _deviceConnectionController.stream;

  late StreamSubscription<void>? _connection;

  final _connectedDevices = <String, Device>{};

  void connect(Device device) async {
    _connection = _subscribeToConnectionStream(device);
    _setConnectionState();
  }

  StreamSubscription<void> _subscribeToConnectionStream(Device device) {
    return ble.connectToDevice(id: device.id).listen(
        (ConnectionStateUpdate update) {
      if (isDeviceNotConnectedYet(device.id)) {
        if (update.connectionState == DeviceConnectionState.connected) {
          device.connectionStatus = update.connectionState;
          _connectedDevices[device.id] = device;
        }
      }
      // TODO: deal with error
    }, onError: (Object e) => {});
  }

  bool isDeviceNotConnectedYet(String deviceId) {
    return !_connectedDevices.containsKey(deviceId);
  }

  void _setConnectionState() {
    _deviceConnectionController.add(_connectedDevices);
  }

  // TODO: is this correct?
  Future<void> disconnect(String deviceId) async {
    try {
      // de um device por vez, não todos!!!
      _connectedDevices.remove(deviceId);
      _setConnectionState();
    } on Exception catch (e, _) {
      // TODO: deal with error
      rethrow;
    }
  }

  void _clearConnectionSubscription() {
    _connection?.cancel();
    _connection = null;
  }

  Future<void> dispose() async {
    await _deviceConnectionController.close();
    _clearConnectionSubscription();
  }
}

class BleConnectedDevices {
  final Map<String, ConnectionStateUpdate> connectedDevices;

  BleConnectedDevices(this.connectedDevices);
}
