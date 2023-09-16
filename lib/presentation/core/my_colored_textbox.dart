import 'dart:developer';

import 'package:dynamic_tooltip_plotline/application/tooltip/data_provider.dart';
import 'package:dynamic_tooltip_plotline/domain/tooltip/my_color.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/build_helper_widgets.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<Color?> getColor() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return buildColorPicketDialog();
        });
  }

  Widget buildColorPicketDialog() {
    Color? color;
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: const Text(
        'Choose Text Color',
        style: headlineMedium,
      ),
      content: Column(
        children: [
          Expanded(
            child: buildMyColorPicker(_defaultColor, (p0) {
              color = p0;
            }),
          ),
          buildTextButton(doneIcon, 'Select Color', () {})
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      // color: Colors.white,
      decoration: defaultContainerDecoration,
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: _defaultColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.centerLeft,
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
              Color? color = await getColor();

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
  }
}
