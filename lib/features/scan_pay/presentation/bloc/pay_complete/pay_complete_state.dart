import 'package:equatable/equatable.dart';

class PayCompleteState extends Equatable {
  const PayCompleteState();

  @override
  List<Object> get props => [];
}

class PayCompleteInitial extends PayCompleteState {
  const PayCompleteInitial();
}

class PayCompleteLoading extends PayCompleteState {
  const PayCompleteLoading();
}

class PayCompleteLoaded extends PayCompleteState {
  final String trxId;
  const PayCompleteLoaded(this.trxId);

  @override
  List<Object> get props => [trxId];
}

class PayCompleteLoadFailed extends PayCompleteState {
  final String message;
  const PayCompleteLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
