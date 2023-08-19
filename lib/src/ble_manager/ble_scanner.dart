import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleScanner {
  final _devices = <String, BluetoothDevice>{};

  final StreamController<BleScannerState> _stateStreamController =
      StreamController.broadcast();

  Stream<BleScannerState> get state => _stateStreamController.stream;

  StreamSubscription? _subscription;

  void startScan() async {
    _clearBeforeScan();
    FlutterBluePlus.startScan();
    _subscription = listenToScanResults();
  }

  StreamSubscription<void> listenToScanResults() {
    return FlutterBluePlus.scanResults.listen((scanResults) {
      for (ScanResult scanResult in scanResults) {
        String remoteId = scanResult.device.remoteId.str;
        _devices.putIfAbsent(remoteId, () => scanResult.device);
      }
      _setScanningState();
    });
  }

  Future<void> stopScan() async {
    await _subscription?.cancel();
    await FlutterBluePlus.stopScan();
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

  final Map<String, BluetoothDevice> discoveredDevices;
  final bool scanIsInProgress;
}
