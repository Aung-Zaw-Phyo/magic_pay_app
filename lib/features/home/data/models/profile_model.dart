import 'package:magic_pay_app/features/home/domain/entities/Profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required String name,
    required String email,
    required String phone,
    required String accountNumber,
    required String balance,
    required String profile,
    required String receiveQrValue,
    required int unreadNotiCount,
  }) : super(
          name: name,
          email: email,
          phone: phone,
          accountNumber: accountNumber,
          balance: balance,
          profile: profile,
          receiveQrValue: receiveQrValue,
          unreadNotiCount: unreadNotiCount,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        accountNumber: json['account_number'],
        balance: json['balance'],
        profile: json['profile'],
        receiveQrValue: json['receive_qr_value'],
        unreadNotiCount: json['unread_noti_count'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "account_number": accountNumber,
        "balance": balance,
        "profile": profile,
        "receive_qr_value": receiveQrValue,
        "unread_noti_count": unreadNotiCount,
      };

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
