import '../../application/tooltip/preview_page_provider.dart';
import '../core/route_navigator.dart';
import '../core/style_elements.dart';
import 'design_tooltip_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../application/tooltip/data_provider.dart';
import '../core/constants.dart';
import '../core/preview_tooltip_page_helpers.dart';

final Map<int, List<String>> indexAndButtons = {
  0: [buttons[0], buttons[1]],
  1: [buttons[2]],
  2: [buttons[3], buttons[4]],
};

class PreviewTooltipPage extends StatefulWidget {
  static const routeName = '/preview';
  const PreviewTooltipPage({super.key});

  @override
  State<PreviewTooltipPage> createState() => _PreviewTooltipPageState();
}

class _PreviewTooltipPageState extends State<PreviewTooltipPage> {
  GlobalKey<TooltipState> key = GlobalKey();
  GlobalKey<TooltipState> key2 = GlobalKey();
  late PreviewPageProvider prov;
  @override
  void initState() {
    super.initState();
    prov = Provider.of<PreviewPageProvider>(context, listen: false);
    prov.setParamState(
        Provider.of<DataProvider>(context, listen: false).params);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  double getTooltipLeftMargin(double width) {
    return (width / 3) / 3;
  }

  @override
  Widget build(BuildContext context) {
    // key.currentState!.ensureTooltipVisible();
    return GestureDetector(
      onTap: () {
        prov.showTooltipForKey(prov.key!);
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundColorTwo,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                RouteNavigator.navigateReplacementWithFade(
                    routeName: DesignTooltipPage.routeName, context: context);
              },
            ),
          ),
          backgroundColor: backgroundColorTwo,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(builder: (context, constraints) {
              prov.setPageConstraints(constraints);

              var horizontalPadding = prov.getHorizontalPadding();
              var verticalPadding = prov.getVerticalPadding();
              var totalWidgetHeight = prov.getTotalWidgetHeight();
              var totalWidgetWidth = prov.getPaddedWidth();

              // double tooltipMarginLeft = getTooltipLeftMargin(totalWidgetWidth);
              // TooltipDirection dir = TooltipDirection.down;

              // double arrowBaseWidth = 40;
              // tooltipVerticalOffset * 0.4;
              // double arrowBaseHeight = 10;

              // double tooltipOffsetHeight = arrowBaseHeight * 2;
              // double tooltipVerticalOffset = arrowBaseHeight + 25;
              // Offset tooltip = Offset(
              //     tooltipMarginLeft + arrowBaseWidth, -tooltipOffsetHeight);
              // Offset(tooltipMarginLeft + 20, -tooltipVerticalOffset * 0.8);
              // double borderRadius = 8;
              // double padding = 15.0;
              return Padding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, verticalPadding,
                    horizontalPadding, verticalPadding),
                child: Column(
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: totalWidgetWidth,
                            height: totalWidgetHeight / 3),
                        child: buildMyRow(
                            buttonIndices: indexAndButtons[0]!,
                            prov: prov,
                            isTop: true)),
                    const Spacer(),
                    ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: totalWidgetWidth,
                            height: totalWidgetHeight / 3),
                        child: buildMyRow(
                            buttonIndices: indexAndButtons[1]!,
                            prov: prov,
                            isCenter: true)),
                    const Spacer(),
                    ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: totalWidgetWidth,
                            height: totalWidgetHeight / 3),
                        child: buildMyRow(
                            buttonIndices: indexAndButtons[2]!,
                            prov: prov,
                            isBottom: true)),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
