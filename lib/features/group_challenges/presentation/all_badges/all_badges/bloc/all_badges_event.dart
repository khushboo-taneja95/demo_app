import 'package:equatable/equatable.dart';

abstract class AllBadgesEvent extends Equatable {
  const AllBadgesEvent();

  @override
  List<Object> get props => [];
}

class AllBadgesLoadedEvent extends AllBadgesEvent {
  const AllBadgesLoadedEvent();
  @override
  List<Object> get props => [];
}

class AllBadgesLoadEvent extends AllBadgesEvent {
  const AllBadgesLoadEvent();

  @override
  List<Object> get props => [];
}

class GetAllBadgesClicked extends AllBadgesEvent {
  final int startIndex;
  final int pageSize;
  final String uid;
  final int challengeid;

  const GetAllBadgesClicked(
      {required this.startIndex,
      required this.pageSize,
      required this.uid,
      required this.challengeid});

  @override
  List<Object> get props => [
        startIndex,
        pageSize,
        uid,
        challengeid,
      ];
}
