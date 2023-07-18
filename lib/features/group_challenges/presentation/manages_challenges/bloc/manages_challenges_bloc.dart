import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tres_connect/core/database/entity/vaccination_entity.dart';
part 'manages_challenges_event.dart';
part 'manages_challenges_state.dart';

class ManagesChallengesBloc
    extends Bloc<ManagesChallengesEvent, ManageChallengesState> {
  ManagesChallengesBloc() : super(ManageChallengesInitial()) {}
}
