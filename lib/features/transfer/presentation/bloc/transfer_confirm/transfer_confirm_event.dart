import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';

class TransferConfirmEvent extends Equatable {
  const TransferConfirmEvent();

  @override
  List<Object> get props => [];
}

class TransferConfirm extends TransferConfirmEvent {
  final TransferRequestEntity transferRequestEntity;
  const TransferConfirm(this.transferRequestEntity);

  @override
  List<Object> get props => [transferRequestEntity];
}
