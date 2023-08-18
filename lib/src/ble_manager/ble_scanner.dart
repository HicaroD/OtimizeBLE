import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleScanner {
  final FlutterReactiveBle ble;

  BleScanner({required this.ble});

  final _devices = <DiscoveredDevice>[];

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
      final knownDeviceIndex = _devices.indexWhere(
        (currentDevice) => currentDevice.id == device.id,
      );

      if (knownDeviceIndex >= 0) {
        _devices[knownDeviceIndex] = device;
      } else {
        _devices.add(device);
      }

      _setScanningState();
      // TODO: deal with error
    }, onError: (Object e) => {});
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

  final List<DiscoveredDevice> discoveredDevices;
  final bool scanIsInProgress;
}
