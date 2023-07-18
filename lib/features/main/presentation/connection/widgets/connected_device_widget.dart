import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/main/presentation/connection/bloc/connection_bloc.dart';

class ConnectedDeviceWidget extends StatelessWidget {
  const ConnectedDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? deviceName = getIt<SharedPreferences>().getString("device_name");
    String? deviceAddress =
        getIt<SharedPreferences>().getString("device_address");
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(30, 100, 30, 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ]),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "My Devices",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/device_care.png",
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$deviceName",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const Spacer(),
                    TextButton(
                      child: const Text(
                        "Unpair",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                      ),
                      onPressed: () {
                        // getIt<SharedPreferences>().remove("device_name");
                        // getIt<SharedPreferences>().remove("device_address");
                        context
                            .read<DeviceConnectionBloc>()
                            .add(UnpairBtnClicked());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Builder(builder: (context) {
          int? timestamp = getIt<SharedPreferences>().getInt("last_sync_time");
          print("last_sync_time:  $timestamp");
          if (timestamp == null) return const SizedBox();
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
          return Text(
            "Last data synched at ${DateUtility.formatDateTime(dateTime: dateTime, outputFormat: 'dd/MM/yyyy hh:mm a')}",
            style: const TextStyle(color: Palette.darkgrey, fontSize: 14),
          );
        })
      ],
    );
  }
}
