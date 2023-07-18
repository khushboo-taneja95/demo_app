import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tres_connect/core/database/database.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/utility/EncodeUtils.dart';
import 'package:tres_connect/features/auth/domain/usecases/get_qr_code_usecase.dart';
import 'package:tres_connect/features/auth/domain/usecases/update_profie_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<AskPermissionEvent>(_onAskPermissionEvent);
    on<DashboardInitialEvent>(_onDashboardInitialEvent);
  }

  void _onAskPermissionEvent(
      AskPermissionEvent event, Emitter<DashboardState> emit) async {
    //Ask permission
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.bluetoothScan,
      Permission.bluetoothConnect
    ].request();
    for (var status in statuses.values) {
      if (status.isDenied) {
        emit(DashboardPermissionDenied(
            deniedPermissions:
                statuses.values.where((element) => element.isDenied).toList()));
      }
    }
    emit(DashboardPermissionGranted());
  }

  void _onDashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    final profile = await getIt<AppDatabase>().userProfileDao.getUserProfile();
    if (profile != null) {
      add(AskPermissionEvent());
      // You can can also directly ask the permission about its status.
      if (await Permission.location.isRestricted) {
        // The OS restricts access, for example because of parental controls.
      }
      //Send profile information to server
      //create usecase in dashboard module
      await UpdateProfileUseCase(repository: getIt()).call(profile);
      try {
        //Get user's QR Code
        String? qrCode = getIt<SharedPreferences>().getString("qr_code");
        if (qrCode == null || qrCode.isEmpty) {
          String fullname =
              "${EncodeUtils.decodeBase64(profile.firstName)} ${EncodeUtils.decodeBase64(profile.lastName)}";
          GetQRCodeUseCase(repository: getIt())
              .call(GetQRCodeUseCaseParams(
                  name: EncodeUtils.encodeBase64(fullname.trim()),
                  uid: EncodeUtils.encodeBase64(profile.uID!)))
              .then((value) {
            value.fold((l) => null, (r) {
              if (r.qRCodeBase64 != null) {
                getIt<SharedPreferences>()
                    .setString("qr_code", r.qRCodeBase64!);
              }
            });
          });
        }
      } catch (e) {
        print(e);
      }
    }
    emit(DashboardReady());
  }
}
