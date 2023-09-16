import 'dart:developer';

import 'package:dynamic_tooltip_plotline/presentation/core/build_helper_widgets.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../core/bubble_shape.dart';

class PreviewTooltipPage extends StatefulWidget {
  const PreviewTooltipPage({super.key});

  @override
  State<PreviewTooltipPage> createState() => _PreviewTooltipPageState();
}

class _PreviewTooltipPageState extends State<PreviewTooltipPage> {
  GlobalKey<TooltipState> key = GlobalKey();
  GlobalKey<TooltipState> key2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      key.currentState!.ensureTooltipVisible();
      key2.currentState!.ensureTooltipVisible();
    });
  }

  double getTooltipLeftMargin(double width) {
    return (width / 3) / 3;
  }

  @override
  Widget build(BuildContext context) {
    // key.currentState!.ensureTooltipVisible();
    return Scaffold(
        backgroundColor: backgroundColorTwo,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(builder: (context, constraints) {
            var horizontalPadding =
                constraints.maxWidth * horizontalPaddingFactor;
            var verticalPadding = constraints.maxHeight * 0.02;
            var totalWidgetHeight = constraints.maxHeight * 0.38;
            var totalWidgetWidth = constraints.maxWidth - 2 * horizontalPadding;
            double tooltipVerticalOffset = 45;
            double tooltipMarginLeft = getTooltipLeftMargin(totalWidgetWidth);
            TooltipDirection dir = TooltipDirection.down;
            Offset tooltip = Offset(
                tooltipMarginLeft + 20,
                dir == TooltipDirection.down
                    ? tooltipVerticalOffset * 0.8 * -1
                    : tooltipVerticalOffset * 0.8);

            double arrowBaseWidth = tooltipVerticalOffset * 0.4;
            double arrowBaseHeight = tooltipVerticalOffset * 0.5;

            return Padding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
                  horizontalPadding, verticalPadding),
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: totalWidgetWidth, height: totalWidgetHeight / 3),
                    child: Row(children: [
                      Expanded(
                        child: Tooltip(
                            key: key2,
                            message: 'This is my second tooltip',
                            // height: 20,
                            verticalOffset: tooltipVerticalOffset,
                            margin: EdgeInsets.only(left: tooltipMarginLeft),
                            decoration: ShapeDecoration(
                              shape: BubbleShape(
                                preferredDirection: TooltipDirection.down,
                                target: tooltip,
                                borderRadius: 6,
                                arrowBaseWidth: arrowBaseWidth,
                                arrowTipDistance: arrowBaseHeight,
                                borderColor: Colors.black,
                                borderWidth: 2,
                              ),
                              color: Colors.black,
                            ),
                            // preferBelow: true,
                            enableFeedback: true,
                            // triggerMode: TooltipTriggerMode.manual,
                            onTriggered: () {
                              log('Run triggered');
                            },
                            child: buildTooltipButton()),
                      ),
                      const Spacer(),
                      Expanded(child: buildTooltipButton())
                    ]),
                  ),
                  const Spacer(),
                  Container(
                    // color: Colors.yellow,
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: totalWidgetWidth,
                          height: totalWidgetHeight / 3),
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // color: Colors.red,
                              child: Tooltip(
                                  key: key,
                                  message: 'This is my first tooltip',
                                  verticalOffset: tooltipVerticalOffset,
                                  margin:
                                      EdgeInsets.only(left: tooltipMarginLeft),
                                  decoration: ShapeDecoration(
                                    shape: BubbleShape(
                                      preferredDirection: TooltipDirection.down,
                                      target: tooltip,
                                      borderRadius: 6,
                                      arrowBaseWidth: arrowBaseWidth,
                                      arrowTipDistance: arrowBaseHeight,
                                      borderColor: Colors.black,
                                      borderWidth: 2,
                                    ),
                                    color: Colors.black,
                                  ),
                                  child: buildTooltipButton()),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: totalWidgetWidth, height: totalWidgetHeight / 3),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildTooltipButton(),
                          ColoredBox(
                            color: Colors.red,
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: buildTooltipButton()),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    color: Colors.yellow,
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'assets/gifs/arrow.gif',
                                      color: Colors.red,
                                      // scale: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
