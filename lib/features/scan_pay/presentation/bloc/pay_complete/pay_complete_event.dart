import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';

class PayCompleteEvent extends Equatable {
  const PayCompleteEvent();

  @override
  List<Object> get props => [];
}

class PayComplete extends PayCompleteEvent {
  final ScanPayRequestEntity scanPayRequestEntity;
  const PayComplete(this.scanPayRequestEntity);

  @override
  List<Object> get props => [scanPayRequestEntity];
}
