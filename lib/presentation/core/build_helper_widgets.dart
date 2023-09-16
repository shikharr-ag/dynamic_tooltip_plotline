import 'package:dynamic_tooltip_plotline/presentation/core/background_style_box.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/my_textbox_template.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'helper.dart';
import 'my_colored_textbox.dart';
import 'my_dropdown.dart';

import 'column_child.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget buildTargetElement(String id, double w) {
  return ColumnChild(
    headline: id,
    widget: MyDropdown(updateTargetElementState: true),
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
      Spacer(),
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

Widget buildRenderTooltipButton(String id, void Function()? onPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
        onPressed: onPressed,
        child: Text(
          id,
          style: bodyMedium.copyWith(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 12, 120, 208),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: onPressed,
        child: Text(
          id,
          style: bodyMedium.copyWith(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 12, 120, 208),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
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

Widget getWidgetFromOrderId(String orderId, double w,
    {void Function()? onPressed}) {
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
    case orderIdRenderTooltip:
      return buildRenderTooltipButton(orderIdRenderTooltip, onPressed);
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
    backgroundColor: Colors.red,
    content: Text(
      t,
      style: bodyMedium.copyWith(color: Colors.white),
    ),
  );
}

Widget buildTooltipButton() {
  return ElevatedButton(
    onPressed: () {},
    child: Text(
      'Button x',
      style: bodyMedium,
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: myRad, side: myBorder.borderSide),
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
