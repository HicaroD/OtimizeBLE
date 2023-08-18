import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otimize_ble/src/ble_manager/device.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_states.dart';

class ConnectedDevicesList extends StatelessWidget {
  const ConnectedDevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocBuilder<BleBloc, BleState>(
        builder: (context, state) {
          if (state is BleConnectedDevicesState) {
            final devices = state.connectedDevices;
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
                );
              },
            );
          } else {
            return const Text('No connected devices.');
          }
        },
      ),
    );
  }
}
