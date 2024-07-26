import 'package:equatable/equatable.dart';

class ScanPayFormDataEntity extends Equatable {
  final String fromName;
  final String fromPhone;
  final String toName;
  final String toPhone;

  const ScanPayFormDataEntity({
    required this.fromName,
    required this.fromPhone,
    required this.toName,
    required this.toPhone,
  });

  @override
  List<Object> get props => [
        fromName,
        fromPhone,
        toName,
        toPhone,
      ];
}
