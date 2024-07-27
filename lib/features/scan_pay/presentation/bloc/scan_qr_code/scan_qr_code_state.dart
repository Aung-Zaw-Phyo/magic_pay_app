import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_form_data.dart';

class ScanQrCodeState extends Equatable {
  const ScanQrCodeState();

  @override
  List<Object> get props => [];
}

class ScanQrCodeInitial extends ScanQrCodeState {
  const ScanQrCodeInitial();
}

class ScanQrCodeLoading extends ScanQrCodeState {
  const ScanQrCodeLoading();
}

class ScanQrCodeLoaded extends ScanQrCodeState {
  final ScanPayFormDataEntity scanPayFormDataEntity;
  const ScanQrCodeLoaded(this.scanPayFormDataEntity);

  @override
  List<Object> get props => [scanPayFormDataEntity];
}

class ScanQrCodeLoadFailed extends ScanQrCodeState {
  final String message;
  const ScanQrCodeLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
