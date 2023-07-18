import 'package:bloc/bloc.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/features/auth/domain/usecases/register_via_email_usecase.dart';
import 'package:equatable/equatable.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterBtnClicked>(_registerBtnClicked);
  }

  void _registerBtnClicked(
      RegisterBtnClicked event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    //api call via repository
    final data = await RegisterViaEmail(repository: getIt()).call(
        RegisterParams(
            name: event.name, email: event.email, password: event.password));
    data.fold((l) {
      emit(RegisterFailure(message: l.message));
    }, (r) {
      emit(RegisterSuccess());
    });
  }
}
