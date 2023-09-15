import 'package:dynamic_tooltip_plotline/presentation/core/my_dropdown.dart';
import 'package:flutter/material.dart';

import 'my_widget_headline.dart';
import 'style_elements.dart';

class ColumnChild extends StatelessWidget {
  final String headline;
  final Widget widget;
  final double width;

  const ColumnChild(
      {super.key,
      required this.headline,
      required this.widget,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red[100],
      constraints: BoxConstraints.expand(),
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      // padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          MyWidgetHeadline(headline: headline),
          // const SizedBox(height: 5),
          Expanded(child: widget),

          // const SizedBox(height: 4),
          // const SizedBox(height: 4),
        ],
      ),
    );
  }
}
