import 'package:equatable/equatable.dart';
import 'package:magic_pay_app/features/scan_pay/domain/entities/scan_pay_data.dart';

class PayConfirmState extends Equatable {
  const PayConfirmState();

  @override
  List<Object> get props => [];
}

class PayConfirmInitial extends PayConfirmState {
  const PayConfirmInitial();
}

class PayConfirmLoading extends PayConfirmState {
  const PayConfirmLoading();
}

class PayConfirmLoaded extends PayConfirmState {
  final ScanPayDataEntity scanPayDataEntity;
  const PayConfirmLoaded(this.scanPayDataEntity);

  @override
  List<Object> get props => [scanPayDataEntity];
}

class PayConfirmLoadFailed extends PayConfirmState {
  final String message;
  const PayConfirmLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
