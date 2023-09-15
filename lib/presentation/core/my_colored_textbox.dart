import 'dart:developer';

import 'package:dynamic_tooltip_plotline/application/tooltip/controller_provider.dart';
import 'package:dynamic_tooltip_plotline/domain/tooltip/my_color.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'style_elements.dart';

class MyColoredTextbox extends StatefulWidget {
  final String id;
  const MyColoredTextbox({super.key, required this.id});

  @override
  State<MyColoredTextbox> createState() => _MyColoredTextboxState();
}

class _MyColoredTextboxState extends State<MyColoredTextbox> {
  Color _defaultColor = Colors.white;
  bool showText = true;

  void validateColorOrCatchError(Color c) {
    DataProvider prov = Provider.of<DataProvider>(context, listen: false);
    MyColor(_defaultColor).value.fold((l) => prov.updateValueFailure(l),
        (r) => prov.add(tooltipParamsMap[widget.id]!, r));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      // color: Colors.white,
      decoration: BoxDecoration(
          border: Border.fromBorderSide(myBorder.borderSide),
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: _defaultColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: showText
                  ? const Text(
                      'Input',
                      style: bodySmall,
                    )
                  : null,
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              Color? color = await showDialog(
                  context: context,
                  builder: (context) {
                    Color? color;
                    return AlertDialog(
                      title: Text(
                        'Choose Text Color',
                        style: headlineMedium,
                      ),
                      content: Column(
                        children: [
                          ColorPicker(
                            pickerColor: _defaultColor,
                            onColorChanged: (c) {
                              color = c;
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Select',
                              style: bodyMedium,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(color);
                            },
                          )
                        ],
                      ),
                    );
                  });
              setState(() {
                _defaultColor = color ?? Colors.white;
                showText = false;
              });

              log('Color picked: $color');
            },
          ),
        ],
      ),
    );
    // TextField(
    //   decoration: InputDecoration(
    //     fillColor: Colors.white,
    //     filled: true,
    //     hintText: 'Input',
    //     hintStyle: Theme.of(context).textTheme.bodySmall,
    //     border: myBorder,
    //     enabledBorder: myBorder,

    //   ),

    //   readOnly: true,

    // );
  }
}
