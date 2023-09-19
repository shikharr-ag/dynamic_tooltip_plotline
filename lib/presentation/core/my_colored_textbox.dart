import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/tooltip/data_provider.dart';
import 'build_helper_widgets.dart';
import 'helper.dart';

import 'style_elements.dart';

class MyColoredTextbox extends StatefulWidget {
  final String id;
  const MyColoredTextbox({super.key, required this.id});

  @override
  State<MyColoredTextbox> createState() => _MyColoredTextboxState();
}

class _MyColoredTextboxState extends State<MyColoredTextbox> {
  late Color _defaultColor;
  // bool showText = true;
  late final FocusNode f;
  late DataProvider prov;
  String hintText = '';

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
          buildTextButton(doneIcon, 'Select Color', () {
            prov.add(Helper.getJsonKeyFromHeadline(widget.id),
                color == null ? _defaultColor.value : color!.value,
                castToInt: true);
            Navigator.of(context).pop(color);
          })
        ],
      ),
    );
  }

  void initialiseVariables() {
    f = FocusNode(debugLabel: widget.id);

    Color? c = prov.getDefaultColor(widget.id);
    if (c == null) {
      _defaultColor = Colors.white;
      hintText = 'Input';
    } else {
      _defaultColor = c;
      hintText = '';
    }
  }

  @override
  void initState() {
    prov = Provider.of<DataProvider>(context, listen: false);
    initialiseVariables();
    super.initState();
  }

  @override
  void dispose() {
    f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: f,
      child: Container(
        constraints: const BoxConstraints.expand(),
        // color: Colors.white,
        decoration: defaultContainerDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text(
                  hintText,
                  style: bodySmall,
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.edit),
              alignment: Alignment.center,
              onPressed: () async {
                f.requestFocus();
                //This delay allows the keyboard animation to get over before calling the dialog
                Future.delayed(const Duration(milliseconds: 100))
                    .then((value) async {
                  Color? color = await getColor();

                  setState(() {
                    _defaultColor = color ?? Colors.white;
                    hintText = '';
                  });

                  log('Color picked: $color');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
