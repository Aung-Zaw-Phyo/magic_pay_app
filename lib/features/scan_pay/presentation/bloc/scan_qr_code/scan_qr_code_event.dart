import 'package:equatable/equatable.dart';

class ScanQrCodeEvent extends Equatable {
  const ScanQrCodeEvent();

  @override
  List<Object> get props => [];
}

class ScanQrCode extends ScanQrCodeEvent {
  final String toPhone;
  const ScanQrCode(this.toPhone);

  @override
  List<Object> get props => [toPhone];
}
