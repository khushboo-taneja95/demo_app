part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class NotificationLoadEvent extends NotificationEvent {
  final bool fetchFromRemote;
  const NotificationLoadEvent({this.fetchFromRemote = false});
  @override
  List<Object> get props => [];
}

class NotificationDeleteEvent extends NotificationEvent {
  final String id;
  const NotificationDeleteEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class NotificationMarkAsReadEvent extends NotificationEvent {
  final String id;
  const NotificationMarkAsReadEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class NotificationMarkAllAsReadEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}
