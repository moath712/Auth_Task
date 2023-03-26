import 'package:flutter/material.dart';
import 'package:flutter_auth_task/style/style.dart';

class TextFieldTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  const TextFieldTitle({Key? key, required this.title, this.isRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Style.mainFont.bodyMedium?.copyWith(
            color: color.secondary,
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
