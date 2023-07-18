import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/main/domain/entities/notification_entity.dart';
import 'package:tres_connect/features/main/domain/usecases/notifications/get_notifications_usecase.dart';
import 'package:tres_connect/features/main/domain/usecases/notifications/mark_notification_read_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationLoadEvent>(_loadNotifications);
    on<NotificationMarkAsReadEvent>(_markNotificationAsRead);
    on<NotificationMarkAllAsReadEvent>(_markAllNotificationsAsRead);
  }

  void _loadNotifications(
      NotificationLoadEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    try {
      String? uid = getIt<SharedPreferences>().getString("uid");
      if (uid == null) {
        emit(const NotificationError(message: "User not logged in"));
        return;
      }
      final data = await GetNotificationsUseCase(repository: getIt()).call(
          NotificationParams(uid: uid, fetchFromRemote: event.fetchFromRemote));
      data.fold((l) => emit(NotificationError(message: l.message)), (r) {
        final unreadNotificationCount =
            r.where((element) => element.isSeen == false).length;
        log("Total Unseen Notifications: $unreadNotificationCount");

        emit(NotificationLoaded(
            notifications: r, unreadCount: unreadNotificationCount));
      });
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  void _markNotificationAsRead(
      NotificationMarkAsReadEvent event, Emitter<NotificationState> emit) {
    emit(NotificationLoading());
    try {
      MarkNotificationReadUseCase(repository: getIt()).call(event.id);
      add(const NotificationLoadEvent(fetchFromRemote: false));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  void _markAllNotificationsAsRead(
      NotificationMarkAllAsReadEvent event, Emitter<NotificationState> emit) {
    emit(NotificationLoading());
    try {
      MarkNotificationReadUseCase(repository: getIt()).call(null);
      add(const NotificationLoadEvent(fetchFromRemote: false));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }
}
