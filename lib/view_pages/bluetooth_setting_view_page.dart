import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/bluetooth_setting_page_controller.dart';

class BluetoothSettingViewPage extends StatelessWidget {
  final BluetoothSettingPageController controller;

  const BluetoothSettingViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bluetooth Settings',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          controller.connectedDevice == null ?
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    'List Available Devices',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                controller.isScanning ?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: LinearProgressIndicator(),
                ) :
                const Material(),
                Expanded(
                  child: controller.bluetoothDeviceScanResult.isNotEmpty ?
                  RefreshIndicator(
                    onRefresh: () async => controller.startScanningDevices(),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      itemCount: controller.bluetoothDeviceScanResult.length,
                      itemBuilder: (BuildContext listContext, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: InkWell(
                            onTap: () => controller.connectedDevice == null ?
                            controller.connectWithDevice(controller.bluetoothDeviceScanResult[index].device) : {},
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    controller.bluetoothDeviceScanResult[index].device.platformName != '' ? controller.bluetoothDeviceScanResult[index].device.platformName : "(Unknown Device)",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Divider(
                                    height: 0.0,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    controller.bluetoothDeviceScanResult[index].device.remoteId.str,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ) :
                  Stack(
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'No Device Found....',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Swipe down to refresh',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      RefreshIndicator(
                        onRefresh: () async => controller.startScanningDevices(),
                        child: ListView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) :
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Bluetooth Status: Connected',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Device Name: ${controller.connectedDevice!.platformName != '' ? controller.connectedDevice!.platformName : 'Unknown'}',
                ),
                Text(
                  'Device Address: ${controller.connectedDevice!.remoteId}',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 5.0,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => controller.disconnectWithDevice(),
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.link_off,
                        color: Colors.red,
                        size: 55.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}