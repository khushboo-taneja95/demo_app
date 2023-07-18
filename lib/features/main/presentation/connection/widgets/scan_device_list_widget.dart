import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/features/main/presentation/connection/bloc/connection_bloc.dart';
import 'package:tres_connect/features/main/presentation/connection/widgets/rssi_widget.dart';

class ScanDeviceListWidget extends StatelessWidget {
  const ScanDeviceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: StreamBuilder(
            initialData: context.read<DeviceConnectionBloc>().deviceList,
            builder: (ctx, snapshot) {
              return ListView.builder(
                  itemCount:
                      context.read<DeviceConnectionBloc>().deviceList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    Map map = context
                        .read<DeviceConnectionBloc>()
                        .deviceList
                        .elementAt(index);
                    return ListTile(
                      minVerticalPadding: kDebugMode ? 0 : 20,
                      title: Text(map['device_name'].toString()),
                      subtitle: kDebugMode
                          ? Text(map['device_address'].toString())
                          : null,
                      trailing: RssiIconWidget(
                          rssi: int.parse(map['rssi'].toString())),
                      onTap: () async {
                        // context.read<DeviceConnectionBloc>().add(BluetoothDeviceClicked(deviceName: map['device_name'].toString(),
                        //     deviceAddress: map['device_address'].toString(),));
                        context
                            .read<DeviceConnectionBloc>()
                            .add(BluetoothDeviceClicked(
                              name: map['device_name'].toString(),
                              address: map['device_address'].toString(),
                            ));
                      },
                    );
                  });
            }),
      ),
    );
    ;
  }
}
