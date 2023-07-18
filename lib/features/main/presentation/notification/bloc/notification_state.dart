part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

class UnreadNotificationCountLoaded extends NotificationState {
  final int count;
  const UnreadNotificationCountLoaded({required this.count});
  @override
  List<Object> get props => [count];
}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  const NotificationLoaded({required this.notifications, this.unreadCount = 0});
  @override
  List<Object> get props => [notifications, unreadCount];
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError({required this.message});
  @override
  List<Object> get props => [message];
}