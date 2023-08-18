import 'dart:typed_data';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class Device {
  final String id;
  final String name;
  Map<Uuid, Uint8List> services;
  Connectable connectable;
  DeviceConnectionState connectionStatus;

  Device({
    required this.id,
    required this.name,
    required this.services,
    required this.connectable,
    this.connectionStatus = DeviceConnectionState.disconnected,
  });

  @override
  String toString() {
    return "Device($id, '$name', $connectable, $connectionStatus";
  }
}
