import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_pay_app/features/scan_pay/domain/usecases/scan_qr_code.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_event.dart';
import 'package:magic_pay_app/features/scan_pay/presentation/bloc/scan_qr_code/scan_qr_code_state.dart';

class ScanQrCodeBloc extends Bloc<ScanQrCodeEvent, ScanQrCodeState> {
  final ScanQrCodeUseCase _scanQrCodeUseCase;

  ScanQrCodeBloc(this._scanQrCodeUseCase) : super(const ScanQrCodeInitial()) {
    on<ScanQrCode>(onScanQrCodee);
  }

  void onScanQrCodee(ScanQrCode event, Emitter<ScanQrCodeState> emit) async {
    emit(const ScanQrCodeLoading());
    final result = await _scanQrCodeUseCase.execute(event.toPhone);
    result.fold((failure) {
      emit(ScanQrCodeLoadFailed(failure.message));
    }, (result) {
      emit(ScanQrCodeLoaded(result));
    });
  }
}
