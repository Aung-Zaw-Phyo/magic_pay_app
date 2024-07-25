import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/transfer/domain/entities/transfer_data.dart';

class TransferConfirmState extends Equatable {
  const TransferConfirmState();

  @override
  List<Object> get props => [];

  get transferData => null;
}

class TransferConfirmInitial extends TransferConfirmState {
  const TransferConfirmInitial();
}

class TransferConfirmLoading extends TransferConfirmState {
  const TransferConfirmLoading();
}

class TransferConfirmLoaded extends TransferConfirmState {
  final TransferDataEntity transferDataEntity;
  const TransferConfirmLoaded(this.transferDataEntity);

  @override
  List<Object> get props => [transferDataEntity];
}

class TransferConfirmLoadFailed extends TransferConfirmState {
  final String message;
  const TransferConfirmLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
