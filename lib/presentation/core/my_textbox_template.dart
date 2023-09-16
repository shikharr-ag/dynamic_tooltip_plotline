import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dynamic_tooltip_plotline/domain/tooltip/my_double.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';

import '../../application/tooltip/data_provider.dart';

enum KeyboardType {
  alphabet,
  numeral,
}

class MyTextboxTemplate extends StatefulWidget {
  final KeyboardType type;

  ///ID is used to get the key for TooltipParams
  final String id;
  final void Function(String)? onSubmit;
  const MyTextboxTemplate({
    Key? key,
    required this.type,
    required this.id,
    this.onSubmit,
  }) : super(key: key);

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
          textAlign: TextAlign.start,
          scrollPadding: EdgeInsets.zero,
          maxLines: 1,
          initialValue: widget.id.isEmpty ? prov.logoUrl : null,
          decoration: InputDecoration(
            fillColor: !isEmpty ? errorColor : Colors.white,
            filled: true,
            hintText: 'Input',
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: !isEmpty ? Colors.white : hintTextColor),
          ),
          cursorColor: !isEmpty ? Colors.white : Colors.black,
          style: bodyMedium.copyWith(
              color: !isEmpty ? Colors.white : Colors.black,
              overflow: TextOverflow.clip),
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
          onFieldSubmitted: widget.onSubmit == null
              ? (val) {
                  if (widget.type != KeyboardType.alphabet) {
                    MyDouble d = MyDouble(val);

                    d.value.fold((l) {
                      log('Error :$l');
                      prov.updateValueFailure(l);
                    }, (r) => prov.add(tooltipParamsMap[widget.id]!, r));
                  } else {
                    prov.add(tooltipParamsMap[widget.id]!, val);
                  }
                }
              : (val) {
                  widget.onSubmit!(val);
                },
        );
      },
    );
  }
}
