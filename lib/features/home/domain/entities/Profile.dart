import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String accountNumber;
  final String balance;
  final String profile;
  final String receiveQrValue;
  final int unreadNotiCount;

  const ProfileEntity({
    required this.name,
    required this.email,
    required this.phone,
    required this.accountNumber,
    required this.balance,
    required this.profile,
    required this.receiveQrValue,
    required this.unreadNotiCount,
  });

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        accountNumber: json['account_number'],
        balance: json['balance'],
        profile: json['profile'],
        receiveQrValue: json['receive_qr_value'],
        unreadNotiCount: json['unread_noti_count'],
      );

  @override
  List<Object> get props => [
        name,
        email,
        phone,
        accountNumber,
        balance,
        profile,
        receiveQrValue,
        unreadNotiCount,
      ];
}
