import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

enum KeyboardType {
  alphabet,
  numeral,
}

class MyTextboxTemplate extends StatefulWidget {
  final KeyboardType type;
  const MyTextboxTemplate({super.key, required this.type});

  @override
  State<MyTextboxTemplate> createState() => _MyTextboxTemplateState();
}

class _MyTextboxTemplateState extends State<MyTextboxTemplate> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: 'Input',
        hintStyle: Theme.of(context).textTheme.bodySmall,
        border: myBorder,
        enabledBorder: myBorder,
      ),
      keyboardType: widget.type == KeyboardType.alphabet
          ? TextInputType.name
          : TextInputType.number,
    );
  }
}
