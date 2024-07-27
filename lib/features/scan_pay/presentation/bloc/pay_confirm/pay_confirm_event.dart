import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_request.dart';

class PayConfirmEvent extends Equatable {
  const PayConfirmEvent();

  @override
  List<Object> get props => [];
}

class PayConfirm extends PayConfirmEvent {
  final ScanPayRequestEntity scanPayRequestEntity;
  const PayConfirm(this.scanPayRequestEntity);

  @override
  List<Object> get props => [scanPayRequestEntity];
}
