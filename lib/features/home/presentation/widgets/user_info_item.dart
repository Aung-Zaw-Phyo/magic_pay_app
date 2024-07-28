import 'package:flutter/material.dart';

class UserInfoItem extends StatelessWidget {
  const UserInfoItem({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
        ),
      ],
    );
  }
}
