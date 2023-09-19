import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../application/tooltip/data_provider.dart';
import '../../application/tooltip/preview_page_provider.dart';
import '../core/constants.dart';
import '../core/preview_tooltip_page_helpers.dart';
import '../core/route_navigator.dart';
import '../core/style_elements.dart';
import 'design_tooltip_page.dart';

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
  late GlobalKey<TooltipState> k;

  late PreviewPageProvider prov;
  @override
  void initState() {
    super.initState();
    prov = Provider.of<PreviewPageProvider>(context, listen: false);
    k = prov.getAndSetGlobalKeyForTooltip('tooltip');
    prov.setParamState(
        Provider.of<DataProvider>(context, listen: false).params);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ///This gives time for tooltip to get built and gets its state

      Future.delayed(const Duration(milliseconds: 40)).then((_) {
        prov.showTooltipForKey(k);

        ///This allows us to get dynamic height of the tooltip
        Future.delayed(const Duration(milliseconds: 12)).then((value) {
          prov.setRuntimeHeight(prov.getCurrentConstraints().height);
        });
      });
      // Future.delayed(Duration(milliseconds: 150), () {

      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    // key.currentState!.ensureTooltipVisible();
    return GestureDetector(
      onTap: () {
        log(prov.key!.currentState!.ensureTooltipVisible().toString());
      },
      onLongPress: () {
        log('Long press');
        log(prov.key!.currentState!.ensureTooltipVisible().toString());
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

              return Padding(
                padding: EdgeInsets.fromLTRB(
                    horizontalPadding, 0, horizontalPadding, verticalPadding),
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
