import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tres_connect/core/bloc/bloc.dart';
import 'package:tres_connect/core/routes/routes.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/features/main/presentation/notification/bloc/notification_bloc.dart';
import 'package:tres_connect/features/main/presentation/notification/widgets/notifcation_row_widget.dart';

class NotificationListWidget extends StatelessWidget {
  final List<NotificationEntity> notifications;

  const NotificationListWidget({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return InkWell(
            onTap: () async {
              await Navigator.pushNamed(context, Routes.notificationDetailPage, arguments: notifications[index]);
              context.read<NotificationBloc>().add(NotificationLoadEvent(fetchFromRemote: false));
            },
            child: NotificationRowWidget(entity: notifications[index],));
      },
      itemCount: notifications.length,
    );
  }
}
