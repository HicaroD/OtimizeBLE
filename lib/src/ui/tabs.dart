import 'package:flutter/material.dart';
import 'package:otimize_ble/src/ui/connected_devices_list.dart';
import 'package:otimize_ble/src/ui/scanned_device_list.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const TabBar(tabs: [
            Tab(text: "Scanned devices"),
            Tab(text: "Connected devices"),
          ]),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: const TabBarView(children: [
              ScannedDeviceList(),
              ConnectedDevicesList(),
            ]),
          ),
        ],
      ),
    );
  }
}
