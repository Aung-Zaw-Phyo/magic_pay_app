import 'package:equatable/equatable.dart';

class ResponseData extends Equatable {
  final bool result;
  final String message;
  final dynamic data;

  const ResponseData({
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        result: json['result'],
        message: json['message'],
        data: json['data'],
      );

  @override
  List<Object> get props => [
        result,
        message,
        data,
      ];
}
