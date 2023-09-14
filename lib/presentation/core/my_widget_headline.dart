import 'package:flutter/material.dart';

class MyWidgetHeadline extends StatelessWidget {
  final String headline;
  const MyWidgetHeadline({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FittedBox(
      child: Text(
        headline,
        style: theme.textTheme.headlineMedium,
      ),
    );
  }
}
