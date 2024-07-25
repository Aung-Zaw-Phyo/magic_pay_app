import 'package:equatable/equatable.dart';

class TransferCompleteState extends Equatable {
  const TransferCompleteState();

  @override
  List<Object> get props => [];
}

class TransferCompleteInitial extends TransferCompleteState {
  const TransferCompleteInitial();
}

class TransferCompleteLoading extends TransferCompleteState {
  const TransferCompleteLoading();
}

class TransferCompleteLoaded extends TransferCompleteState {
  final String trxId;
  const TransferCompleteLoaded(this.trxId);

  @override
  List<Object> get props => [trxId];
}

class TransferCompleteLoadFailed extends TransferCompleteState {
  final String message;
  const TransferCompleteLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
