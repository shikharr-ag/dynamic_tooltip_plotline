import 'dart:developer';

import 'package:dynamic_tooltip_plotline/application/tooltip/data_provider.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../domain/core/failures.dart';
import '../core/build_helper_widgets.dart';
import '../core/constants.dart';
import 'package:flutter/material.dart';

import '../core/helper.dart';

class DesignTooltipPage extends StatefulWidget {
  static const routeName = '/design';
  const DesignTooltipPage({super.key});

  @override
  State<DesignTooltipPage> createState() => _DesignTooltipPageState();
}

class _DesignTooltipPageState extends State<DesignTooltipPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DataProvider>(context, listen: false).addListener(() {
        ValueFailure f =
            Provider.of<DataProvider>(context, listen: false).failure;

        if (f != ValueFailure.none()) {
          ScaffoldMessenger.of(context).showSnackBar(buildMySnackBar(
            Helper.getErrorMessage(f),
          ));
        }
      });
    });
  }

  void onPressedHandler(BuildContext context, GlobalKey<FormState> key) {
    key.currentState!.validate();
    if (Provider.of<DataProvider>(context, listen: false).isFormComplete) {
      //TODO: shared pref
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        buildMySnackBar('Please fill the form completely. :)'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
          backgroundColor: theme.canvasColor,
          // resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(builder: ((context, constraints) {
              // log('Insets: ${MediaQuery.of(context).viewInsets} \t Padding: ${MediaQuery.of(context).viewPadding}');
              // log('MaxHeight: ${constraints.maxHeight}');
              // log('MediaQuery Height: ${MediaQuery.of(context).size.height}');
              var topPadding = constraints.maxHeight * 0.05;
              var bottomPadding = constraints.maxHeight * 0.005;

              var listViewWidgetHeight = MediaQuery.of(context).size.height -
                  (topPadding + bottomPadding);
              var leftAndRightPadding =
                  constraints.maxWidth * horizontalPaddingFactor;
              var listViewWidth =
                  constraints.maxWidth - 2 * leftAndRightPadding;
              log('Bottom padding: $bottomPadding');
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: listViewWidgetHeight / 18,
                      width: listViewWidth * 0.4,
                      alignment: Alignment.centerRight,
                      // color: Colors.yellow,
                      child: Image.asset(
                        'assets/gifs/arrow_nobg.gif',
                        color: Colors.black,
                        // scale: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(leftAndRightPadding,
                        topPadding, leftAndRightPadding, bottomPadding),
                    child: Container(
                      // color: Colors.red[100],
                      constraints: BoxConstraints.tightFor(
                          height: double.infinity, width: listViewWidth),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: (widgetBuildOrder.map((e) {
                            return ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: listViewWidth,
                                    height: listViewWidgetHeight / 8.5),
                                child: getWidgetFromOrderId(e, listViewWidth,
                                    onPressed: () =>
                                        onPressedHandler(context, formKey)));
                          }).toList()),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })),
          )),
    );
  }
}
