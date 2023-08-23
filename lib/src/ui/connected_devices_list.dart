import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_bloc.dart';
import 'package:otimize_ble/src/blocs/ble_bloc/ble_events.dart';

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

  // TODO
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Container(),
    );
  }
}
