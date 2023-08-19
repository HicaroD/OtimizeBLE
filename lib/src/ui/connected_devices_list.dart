import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
            final devices = state.connectedDevices.connectedDevices;
            return ListView.builder(
              itemCount: devices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // NOTE: Slow operations!!
                final List<String> deviceIds = devices.keys.toList();
                final String deviceId = deviceIds[index];
                final BluetoothDevice device = devices[deviceId]!;

                return ListTile(
                  title: Text(device.localName),
                  subtitle: Text(device.remoteId.str),
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
