import 'dart:developer';

import 'package:dynamic_tooltip_plotline/application/tooltip/design_page_provider.dart';
import 'package:dynamic_tooltip_plotline/domain/core/failures.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/background_style_box.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/my_textbox_template.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../application/tooltip/data_provider.dart';
import '../../infrastructure/tooltip/shared_preferences_repository.dart';
import '../pages/preview_tooltip_page.dart';
import 'helper.dart';
import 'my_colored_textbox.dart';
import 'my_dropdown.dart';

import 'column_child.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'route_navigator.dart';

Widget buildTargetElement(String id, double w) {
  return ColumnChild(
    headline: id,
    widget: MyDropdown(
      items: buttons,
      updateTargetElementState: true,
      id: id,
    ),
    width: w,
  );
}

Widget buildTooltipText(String id, double w) {
  return ColumnChild(
    headline: id,
    widget: MyTextboxTemplate(
      type: KeyboardType.alphabet,
      id: id,
    ),
    width: w,
  );
}

Widget buildTextSizeAndPadding(String id1, String id2, double w) {
  return Row(
    children: [
      Expanded(
        flex: 3,
        child: ColumnChild(
          headline: id1,
          widget: MyTextboxTemplate(
            type: KeyboardType.numeral,
            id: id1,
          ),
          width: w,
        ),
      ),
      const Spacer(),
      Expanded(
        flex: 3,
        child: ColumnChild(
          headline: id2,
          widget: MyTextboxTemplate(
            type: KeyboardType.numeral,
            id: id2,
          ),
          width: w,
        ),
      ),
    ],
  );
}

Widget buildRenderTooltipButton(String id1, String id2, DataProvider prov,
    DesignPageProvider dprov, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            // dprov.setLoading();
            prov.formKey.currentState!.validate();
            if (prov.isFormComplete) {
              //TODO: shared pref
              log('${prov
                ..styleFactors
                ..setParams()}');
              SharedPreferencesRepository().storeStyleFactors(prov.params);
              // log('${SharedPreferencesRepository().getStyleFactors()}');
              RouteNavigator.navigateReplacementWithFade(
                  routeName: PreviewTooltipPage.routeName, context: context);
            } else {
              prov.updateValueFailure(const ValueFailure.incompleteForm());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: renderButtonColor,
            shape: defaultElevatedButtonShape,
          ),
          child: Text(
            id1,
            style: bodyMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
      if (prov.hasOldData) ...[
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: ElevatedButton(
          onPressed: () async {
            dprov.setLoading();

            prov.overwriteTooltipParams();
            await Future.delayed(const Duration(milliseconds: 100));
            dprov.setLoaded();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: renderButtonColor,
            shape: defaultElevatedButtonShape,
          ),
          child: Text(
            id2,
            style: bodyMedium.copyWith(color: Colors.white),
          ),
        )),
      ]
    ],
  );
}

Widget buildBackgroundStyle(String id, double w) {
  return ColumnChild(
      headline: id,
      width: w,
      widget: BackgroundStyleBox(
        id: id,
      ));
}

Widget buildColorTextbox(String id, double w) {
  return ColumnChild(
      headline: id,
      width: w,
      widget: MyColoredTextbox(
        id: id,
      ));
}

Widget getWidgetFromOrderId(String orderId, DesignPageProvider dprov,
    DataProvider prov, BuildContext context) {
  double w = dprov.getListViewWidth();
  switch (orderId) {
    case orderIdTargetElement:
      return buildTargetElement(orderIdTargetElement, w);
    case orderIdTooltipText:
      return buildTooltipText(orderIdTooltipText, w);
    case orderIdTextSizePadding:
      List<String> sub = Helper.getSubstrings(orderIdTextSizePadding);
      String id1 = sub[0];
      String id2 = sub[1];
      return buildTextSizeAndPadding(id1, id2, w);
    case orderIdTextColor:
      return buildColorTextbox(orderIdTextColor, w);
    case orderIdBgColor:
      return buildBackgroundStyle(orderIdBgColor, w);
    case orderIdCornerRadTooltipWidth:
      List<String> sub = Helper.getSubstrings(orderIdCornerRadTooltipWidth);
      String id1 = sub[0];
      String id2 = sub[1];
      return buildTextSizeAndPadding(id1, id2, w);
    case orderIdArrowWidthAndWidth:
      List<String> sub = Helper.getSubstrings(orderIdArrowWidthAndWidth);
      String id1 = sub[0];
      String id2 = sub[1];
      return buildTextSizeAndPadding(id1, id2, w);
    case orderIdRenderTooltipAndPreviousStyle:
      List<String> sub =
          Helper.getSubstrings(orderIdRenderTooltipAndPreviousStyle);
      String id1 = sub[0];
      String id2 = sub[1];
      return buildRenderTooltipButton(id1, id2, prov, dprov, context);
    default:
      return Container(height: 0);
  }
}

Widget buildMyColorPicker(
    Color defaultColor, void Function(Color) onColorChanged) {
  return ColorPicker(
    pickerColor: defaultColor,
    enableAlpha: false,
    onColorChanged: onColorChanged,
    pickerAreaHeightPercent: 0.7,
  );
}

SnackBar buildMySnackBar(String t) {
  return SnackBar(
    backgroundColor: errorColor,
    content: Text(
      t,
      style: bodyMedium.copyWith(color: Colors.white),
    ),
  );
}

Widget buildTextButton(IconData icon, String content, void Function()? onTap) {
  return Center(
    child: TextButton.icon(
        onPressed: onTap, icon: Icon(icon), label: Text(content)),
  );
}

Widget buildCustomDialogRow(String headline, Widget w) {
  return Row(
    children: [
      Expanded(
        child: Text(
          headline,
          style: bodyMedium,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(flex: 2, child: w),
    ],
  );
}

Center buildLoader() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
