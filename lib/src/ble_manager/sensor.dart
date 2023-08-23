import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:otimize_ble/src/ble_manager/ble_commands.dart';

class Sensor {
  final BluetoothDevice device;
  final List<BluetoothService> services;

  Sensor({
    required this.device,
    required this.services,
  });

  void writeCharacteristic(BleCommand command) {
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print(characteristic.serviceUuid.toString());
      }
    }
  }
}
