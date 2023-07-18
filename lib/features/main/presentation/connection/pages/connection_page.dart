import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/bloc/global/global_bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/core/utility/DateUtility.dart';
import 'package:tres_connect/features/main/presentation/connection/bloc/connection_bloc.dart';
import 'package:tres_connect/features/main/presentation/connection/widgets/connected_device_widget.dart';
import 'package:tres_connect/features/main/presentation/connection/widgets/scan_device_list_widget.dart';
import 'package:tres_connect/widgets/dialogs/my_dialog.dart';
import 'package:tres_connect/widgets/tres_btn.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DeviceConnectionBloc>(context).add(CheckConnected());
    return const ConnectionScreenBody();
  }
}

class ConnectionScreenBody extends StatelessWidget {
  const ConnectionScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeviceConnectionBloc, DeviceConnectionState>(
      listener: (context, state) {
        //Global Bloc is listening to state changes in DeviceConnectionBloc and will handle the data sync operations
        if (state is DeviceConnected) {
          Future.delayed(const Duration(seconds: 1), () {
            BlocProvider.of<GlobalBloc>(context)
                .add(const SyncDeviceAndWatch());
            int timestamp =
                getIt<SharedPreferences>().getInt("last_sync_time") ?? 0;
            final lastSyncTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
            // if (lastSyncTime.isBefore(
            //     DateTime.now().subtract(const Duration(minutes: 10)))) {
            //   BlocProvider.of<GlobalBloc>(context)
            //       .add(const FetchHealthReadings(medicalCode: "HR"));
            // }
            BlocProvider.of<GlobalBloc>(context)
                .add(const FetchHealthReadings(medicalCode: "HR"));
          });
        }
        if (state is DeviceConnectionInitial) {
          if (state.bluetoothState == 0) {
            showDialog(
                context: context,
                builder: (_) => MyDialog(
                    title: "Bluetooth Off",
                    message: "Please enable bluetooth to connect to the device",
                    isSingleBtn: true,
                    dialogType: Type.ERROR,
                    onPositiveBtnClicked: () {
                      Navigator.pop(context);
                    },
                    onNegativeBtnClicked: () {}));
          }
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state is DeviceConnecting) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please wait while device is connecting..."),
              ));
              return Future.value(false);
            }
            if (state is ScanStarted) {
              context.read<DeviceConnectionBloc>().add(ScanBtnClicked());
              return Future.value(true);
            }
            return Future.value(true);
          },
          child: Scaffold(
              appBar: AppBar(
                title: const Text("Band Connection"),
                centerTitle: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 50),
                  Builder(builder: (ctx) {
                    String address;
                    if (state is DeviceConnected) {
                      address = "assets/images/band_connected_new.png";
                    } else if (state is DeviceConnecting ||
                        state is ScanStarted) {
                      address = "assets/images/band_connection_progress.gif";
                    } else {
                      address = "assets/images/band_connection_new.png";
                    }
                    return Center(
                      child: Image.asset(
                        address,
                        width: 150,
                        height: 150,
                      ),
                    );
                  }),
                  Builder(builder: (ctx) {
                    if (state is DeviceConnected) {
                      return const ConnectedDeviceWidget();
                    } else if (state is ScanStarted ||
                        state is DeviceConnectionInitial) {
                      return const ScanDeviceListWidget();
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
              bottomNavigationBar: Builder(builder: (ctx) {
                if (state is DeviceConnected || state is DeviceConnecting) {
                  return const SizedBox();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: MyButton(
                      text: state is ScanStarted
                          ? "Stop Scan"
                          : "Search with Bluetooth",
                      bgColor: Palette.secondaryColor1,
                      onClick: () {
                        context
                            .read<DeviceConnectionBloc>()
                            .add(ScanBtnClicked());
                      },
                    ),
                  );
                }
              })),
        );
      },
    );
  }
}
