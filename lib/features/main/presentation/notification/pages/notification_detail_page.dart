import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/features/main/presentation/notification/bloc/notification_bloc.dart';
import 'package:tres_connect/features/main/presentation/notification/widgets/notifcation_row_widget.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const NotificationDetailPage({Key? key, required this.notificationEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationBloc(),
      child: Scaffold(
        body: NotificationDetailPageBody(notificationEntity: notificationEntity,),
      ),
    );;
  }
}

class NotificationDetailPageBody extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const NotificationDetailPageBody({Key? key, required this.notificationEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NotificationBloc>().add(NotificationMarkAsReadEvent(id: notificationEntity.notificationId!));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Notifications',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      ),
      body: NotificationRowWidget(entity: notificationEntity,showArrow: false),
    );
  }
}
