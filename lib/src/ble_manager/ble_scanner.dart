import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:otimize_ble/src/ble_manager/device.dart';

class BleScanner {
  final FlutterReactiveBle ble;

  BleScanner({required this.ble});

  final _devices = <String, Device>{};

  final StreamController<BleScannerState> _stateStreamController =
      StreamController();

  Stream<BleScannerState> get state => _stateStreamController.stream;

  StreamSubscription? _subscription;

  void startScan() {
    _clearBeforeScan();
    _subscription = subscribeToDeviceScanningStream();
    _setScanningState();
  }

  StreamSubscription<void> subscribeToDeviceScanningStream() {
    return ble.scanForDevices(withServices: []).listen((device) {
      Device scannedDevice = Device(
        id: device.id,
        name: device.name,
        services: device.serviceData,
        connectable: device.connectable,
      );

      if (isKnownDevice(device.id)) {
        _devices[device.id] = scannedDevice;
      } else {
        _devices.putIfAbsent(device.id, () => scannedDevice);
      }

      _setScanningState();
      // TODO: deal with error
    }, onError: (Object e) => {});
  }

  bool isKnownDevice(String deviceId) {
    return _devices.containsKey(deviceId);
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    _subscription = null;
    _setScanningState();
  }

  void _setScanningState() {
    _stateStreamController.add(
      BleScannerState(
        discoveredDevices: _devices,
        scanIsInProgress: _subscription != null,
      ),
    );
  }

  void _clearBeforeScan() {
    _devices.clear();
    _subscription?.cancel();
  }

  Future<void> dispose() async {
    await _stateStreamController.close();
  }
}

class BleScannerState {
  const BleScannerState({
    required this.discoveredDevices,
    required this.scanIsInProgress,
  });

  final Map<String, Device> discoveredDevices;
  final bool scanIsInProgress;
}
