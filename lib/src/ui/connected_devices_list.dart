import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_states.dart';

class ConnectedDevicesList extends StatefulWidget {
  const ConnectedDevicesList({super.key});

  @override
  State<ConnectedDevicesList> createState() => _ConnectedDevicesListState();
}

class _ConnectedDevicesListState extends State<ConnectedDevicesList> {
  @override
  void initState() {
    super.initState();
    context.read<BleBloc>().add(BleConnectedDevicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BlocBuilder<BleBloc, BleState>(
        builder: (context, state) {
          if (state is BleConnectedDevicesState) {
            final devices = state.devices;
            return ListView.builder(
              itemCount: devices.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final BluetoothDevice device = devices[index];
                return ListTile(
                  title: Text(device.localName),
                  subtitle: Text(device.remoteId.str),
                );
              },
            );
          } else if (state is BleLoadingState) {
            return const CircularProgressIndicator();
          } else {
            return const Text('No connected devices.');
          }
        },
      ),
    );
  }
}
