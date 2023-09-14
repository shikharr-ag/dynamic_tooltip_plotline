import 'package:dynamic_tooltip_plotline/presentation/core/my_textbox_template.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';

import 'helper.dart';
import 'my_dropdown.dart';

import 'column_child.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget buildTargetElement(String id, double w) {
  return ColumnChild(
    headline: id,
    widget: MyDropdown(),
    width: w,
  );
}

Widget buildTooltipText(String id, double w) {
  return ColumnChild(
    headline: id,
    widget: MyTextboxTemplate(type: KeyboardType.alphabet),
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
            type: KeyboardType.alphabet,
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
            type: KeyboardType.alphabet,
          ),
          width: w,
        ),
      ),
    ],
  );
}

Widget buildRenderTooltipButton(String id) {
  return Center(
    child: ElevatedButton(
      onPressed: () {},
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
  );
}

Widget getWidgetFromOrderId(String orderId, double w) {
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
      return buildTargetElement(orderIdTextColor, w);
    case orderIdBgColor:
      return buildTargetElement(orderIdBgColor, w);
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
      return buildRenderTooltipButton(orderIdRenderTooltip);
    default:
      return Container(height: 0);
  }
}
