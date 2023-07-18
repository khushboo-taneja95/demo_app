import 'package:flutter/material.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/features/main/presentation/notification/bloc/notification_bloc.dart';
import 'package:tres_connect/widgets/loading_widget.dart';
import 'package:tres_connect/features/main/presentation/notification/widgets/notification_list.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc()
        ..add(const NotificationLoadEvent(fetchFromRemote: false)),
      child: const Scaffold(
        body: NotificationBody(),
      ),
    );
  }
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Notifications',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.checklist),
                tooltip: "Mark all as read",
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                    title: const Text("Mark all as read"),
                    content: const Text(
                        "Are you sure you want to mark all notifications as read?"),
                    actions: [
                      TextButton(
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Palette.primaryColor),
                        ),
                        onPressed: () {
                          context
                              .read<NotificationBloc>()
                              .add(NotificationMarkAllAsReadEvent());
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "No",
                          style: TextStyle(color: Palette.primaryColor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (ctx) => alert);
                },
              )
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<NotificationBloc>()
                  .add(const NotificationLoadEvent(fetchFromRemote: true));
            },
            child: Builder(builder: (ctx) {
              if (state is NotificationLoading) {
                return const Center(child: LoadingWidget());
              } else if (state is NotificationLoaded) {
                return NotificationListWidget(
                    notifications: state.notifications);
              } else if (state is NotificationError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(child: Text("No notifications"));
            }),
          ),
        );
      },
    );
  }
}
