import 'dart:developer';

import 'package:dynamic_tooltip_plotline/application/tooltip/design_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../application/tooltip/data_provider.dart';
import '../../domain/core/failures.dart';
import '../../infrastructure/tooltip/shared_preferences_repository.dart';
import '../core/build_helper_widgets.dart';
import '../core/constants.dart';
import '../core/helper.dart';

class DesignTooltipPage extends StatefulWidget {
  static const routeName = '/design';
  const DesignTooltipPage({super.key});

  @override
  State<DesignTooltipPage> createState() => _DesignTooltipPageState();
}

class _DesignTooltipPageState extends State<DesignTooltipPage> {
  late GlobalKey<FormState> formKey;
  late final DataProvider prov;

  @override
  void dispose() {
    prov.removeListener(() {});
    super.dispose();
  }

  void initialiseVariables() {
    prov = Provider.of<DataProvider>(context, listen: false);
    formKey = prov.formKey;
    prov.checkHasOldData();
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
    initialiseVariables();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      prov.addListener(() {
        ValueFailure f = prov.failure;
        if (f != const ValueFailure.none()) {
          ScaffoldMessenger.of(context).showSnackBar(buildMySnackBar(
            Helper.getErrorMessage(f),
          ));
        }
      });
    });
  }

  // void onPressedHandler(BuildContext context, GlobalKey<FormState> key) {
  //   key.currentState!.validate();
  //   if (prov.isFormComplete) {
  //     //TODO: shared pref
  //     log('${prov
  //       ..styleFactors
  //       ..setParams()}');
  //     SharedPreferencesRepository().storeStyleFactors(prov.params);
  //     log('${SharedPreferencesRepository().getStyleFactors()}');
  //     // RouteNavigator.navigateReplacementWithFade(
  //     //     routeName: PreviewTooltipPage.routeName, context: context);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       buildMySnackBar('Please fill the form completely. :)'),
  //     );
  //   }
  // }

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
            child: Consumer<DesignPageProvider>(builder: (context, dprov, _) {
              return LayoutBuilder(builder: ((context, constraints) {
                dprov.setConstraints(constraints);
                // log('Insets: ${MediaQuery.of(context).viewInsets} \t Padding: ${MediaQuery.of(context).viewPadding}');
                // log('MaxHeight: ${constraints.maxHeight}');
                // log('MediaQuery Height: ${MediaQuery.of(context).size.height}');
                var topPadding = dprov.getTopPadding();
                var bottomPadding = dprov.getBottomPadding();

                var listViewWidgetHeight = MediaQuery.of(context).size.height -
                    (topPadding + bottomPadding);
                var leftAndRightPadding = dprov.getHorizontalPadding();
                var listViewWidth = dprov.getListViewWidth();
                log('Bottom padding: $bottomPadding');
                return dprov.isLoading
                    ? buildLoader()
                    : Padding(
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
                                    child: getWidgetFromOrderId(
                                        e, dprov, prov, context));
                              }).toList()),
                            ),
                          ),
                        ),
                      );
              }));
            }),
          )),
    );
  }
}
