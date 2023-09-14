import 'dart:developer';

import '../core/build_helper_widgets.dart';
import '../core/constants.dart';
import 'package:flutter/material.dart';

class DesignTooltipPage extends StatefulWidget {
  const DesignTooltipPage({super.key});

  @override
  State<DesignTooltipPage> createState() => _DesignTooltipPageState();
}

class _DesignTooltipPageState extends State<DesignTooltipPage> {
  //TextEditingControllers
  // TextEditingController tooltipText = TextEditingController();
  // TextEditingController textSize = TextEditingController();
  // TextEditingController textPadding = TextEditingController();
  // TextEditingController cornerRadius = TextEditingController();
  // TextEditingController tooltipWidth = TextEditingController();
  // TextEditingController arrowWidth = TextEditingController();
  // TextEditingController arrowHeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
          backgroundColor: theme.canvasColor,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(builder: ((context, constraints) {
            // log('Insets: ${MediaQuery.of(context).viewInsets} \t Padding: ${MediaQuery.of(context).viewPadding}');
            var topPadding = constraints.maxHeight * 0.05;
            var bottomPadding = constraints.maxHeight * 0.005;
            var listViewHeight =
                constraints.maxHeight - (topPadding + bottomPadding);
            var leftAndRightPadding = constraints.maxWidth * 0.08;
            var listViewWidth = constraints.maxWidth - 2 * leftAndRightPadding;
            return Padding(
              padding: EdgeInsets.fromLTRB(leftAndRightPadding, topPadding,
                  leftAndRightPadding, bottomPadding),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      height: listViewHeight, width: listViewWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: (widgetBuildOrder.map((e) {
                      return Expanded(
                          child: getWidgetFromOrderId(e, listViewWidth));
                    }).toList()),
                    // [
                    //   // Expanded(
                    //   //     child: ColumnChildDropdown(
                    //   //         headline: targetElement,widget: MyDropdown(),)),
                    //   // Expanded(
                    //   //     child: ColumnChildTextBox(
                    //   //   headline: targetElement,
                    //   //   controller: TextEditingController(),
                    //   //   type: KeyboardType.alphabet,
                    //   // )),
                    //   // Spacer(
                    //   //   flex: 4,
                    //   // ),
                    // ]
                  ),
                ),
              ),
            );
          }))),
    );
  }
}
