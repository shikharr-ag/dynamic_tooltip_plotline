import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/tooltip/data_provider.dart';
import '../../domain/tooltip/my_double.dart';
import 'helper.dart';
import 'style_elements.dart';

enum KeyboardType {
  alphabet,
  numeral,
}

class MyTextboxTemplate extends StatefulWidget {
  final KeyboardType type;

  ///ID is used to get the key for TooltipParams
  final String id;
  final void Function(String)? onSubmit;
  final bool isUrl;
  const MyTextboxTemplate({
    Key? key,
    required this.type,
    required this.id,
    this.onSubmit,
    this.isUrl = false,
  }) : super(key: key);

  @override
  State<MyTextboxTemplate> createState() => _MyTextboxTemplateState();
}

class _MyTextboxTemplateState extends State<MyTextboxTemplate> {
  late final FocusNode f;
  late final TextEditingController ctrl;
  late final DataProvider prov;

  ///This variable indicates the presence of this key in the state
  ///If absent that means field is empty
  bool isEmpty = true;

  void addKVToState() {
    if (widget.type == KeyboardType.alphabet) {
    } else {
      if (ctrl.text.isNotEmpty) {
        prov.add(Helper.getJsonKeyFromHeadline(widget.id), ctrl.text,
            castToDouble: widget.type == KeyboardType.numeral ? true : false);
      }
    }
  }

  void initialiseVariables() {
    // log('Params: ${prov.params}');

    f = FocusNode(debugLabel: widget.id);
    Object? j = prov.getValFromParams(widget.id, isUrl: widget.isUrl);
    ctrl = TextEditingController(text: j == null ? '' : j.toString());
  }

  @override
  void initState() {
    prov = Provider.of<DataProvider>(context, listen: false);
    // log('building form field');
    initialiseVariables();
    f.addListener(() {
      // log('Focus changed :${f.debugLabel} ${f.hasFocus}');
      if (!f.hasFocus) {
        validateAndProcessValue(ctrl.text);
      }
    });
    super.initState();
  }

  void validateAndProcessValue(String val) {
    if (widget.type == KeyboardType.numeral) {
      MyDouble d = MyDouble(val);

      d.value.fold((l) {
        ctrl.text = '0';
        prov.updateValueFailure(l);
      }, (r) => addKVToState());
    } else {
      addKVToState();
    }
  }

  @override
  void dispose() {
    f.dispose();
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, prov, _) {
        return TextFormField(
          controller: ctrl,
          focusNode: f,
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
            // log('validate');
            isEmpty = prov.checkIfValueAbsent(widget.id);

            ///Rebuild UI to reflect state
            setState(() {});

            return null;
          },
          onFieldSubmitted: widget.onSubmit == null
              ? (val) {
                  validateAndProcessValue(val);
                }
              : (val) {
                  widget.onSubmit!(val);
                },
        );
      },
    );
  }
}
