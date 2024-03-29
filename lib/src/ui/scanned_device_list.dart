import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otimize_ble/src/ble_manager/device.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_states.dart';

class ScannedDeviceList extends StatelessWidget {
  const ScannedDeviceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocBuilder<BleBloc, BleState>(
        builder: (context, state) {
          if (state is BleScannedDevicesState) {
            final devices = state.scanResult.discoveredDevices;
            return ListView.builder(
              itemCount: devices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // NOTE: Slow operations!!
                final List<String> deviceIds = devices.keys.toList();
                final String deviceId = deviceIds[index];
                final Device device = devices[deviceId]!;

                return ListTile(
                  title: Text(device.name),
                  subtitle: Text(device.id),
                  onTap: () => context
                      .read<BleBloc>()
                      .add(BleConnectToDeviceEvent(device)),
                );
              },
            );
          }
          return const Text('No devices found.');
        },
      ),
    );
  }
}
