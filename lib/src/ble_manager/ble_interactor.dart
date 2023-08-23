import 'package:otimize_ble/src/ble_manager/ble_commands.dart';
import 'package:otimize_ble/src/ble_manager/sensor.dart';

class BleInteractor {
  final List<Sensor> connectedSensors;

  BleInteractor(this.connectedSensors);

  void write(BleCommand command) {
    for (Sensor sensor in connectedSensors) {
      sensor.writeCharacteristic(BleCommand.StartEvaluation);
    }
  }
}
