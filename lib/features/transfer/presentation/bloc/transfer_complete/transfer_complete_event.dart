import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_request.dart';

class TransferCompleteEvent extends Equatable {
  const TransferCompleteEvent();

  @override
  List<Object> get props => [];
}

class TransferComplete extends TransferCompleteEvent {
  final TransferRequestEntity transferRequestEntity;
  const TransferComplete(this.transferRequestEntity);

  @override
  List<Object> get props => [transferRequestEntity];
}
