import 'dart:developer';

import 'package:dynamic_tooltip_plotline/domain/tooltip/my_double.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../application/tooltip/controller_provider.dart';

enum KeyboardType {
  alphabet,
  numeral,
}

class MyTextboxTemplate extends StatefulWidget {
  final KeyboardType type;

  ///ID is used to get the key for TooltipParams
  final String id;
  const MyTextboxTemplate({super.key, required this.type, required this.id});

  @override
  State<MyTextboxTemplate> createState() => _MyTextboxTemplateState();
}

class _MyTextboxTemplateState extends State<MyTextboxTemplate> {
  ///This variable indicates the presence of this key in the state
  ///If absent that means field is empty
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, prov, _) {
        return TextFormField(
          decoration: InputDecoration(
            fillColor: !isEmpty ? Colors.red : Colors.white,
            filled: true,
            hintText: 'Input',
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: !isEmpty ? Colors.white : Colors.black),
            border: myBorder,
            enabledBorder: myBorder,
            errorBorder: myBorder,
            errorStyle: bodySmall.copyWith(fontSize: 5),
          ),
          cursorColor: !isEmpty ? Colors.white : Colors.black,
          style: bodyMedium.copyWith(
              color: !isEmpty ? Colors.white : Colors.black),
          keyboardType: widget.type == KeyboardType.alphabet
              ? TextInputType.name
              : TextInputType.number,
          validator: (x) {
            log('validate');
            isEmpty = prov.checkIfValueAbsent(widget.id);

            ///Rebuild UI to reflect state
            setState(() {});

            return null;
          },
          onFieldSubmitted: (val) {
            if (widget.type != KeyboardType.alphabet) {
              MyDouble d = MyDouble(val);

              d.value.fold((l) {
                log('Error :$l');
                Provider.of<DataProvider>(context, listen: false)
                    .updateValueFailure(l);
              },
                  (r) => Provider.of<DataProvider>(context, listen: false)
                      .add(tooltipParamsMap[widget.id]!, r));
            } else {
              Provider.of<DataProvider>(context, listen: false)
                  .add(tooltipParamsMap[widget.id]!, val);
            }
          },
        );
      },
    );
  }
}
