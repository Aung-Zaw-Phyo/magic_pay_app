import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: const Color.fromARGB(173, 0, 0, 0), fontSize: 17),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),
        ),
      ],
    );
  }
}
