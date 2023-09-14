import 'package:dynamic_tooltip_plotline/presentation/core/style_elements.dart';
import 'package:flutter/material.dart';

final List<DropdownMenuItem<String>> buttons = List.generate(
    5,
    (index) => DropdownMenuItem(
        value: 'Button${index + 1}',
        child: Text(
          'Button${index + 1}',
          style: bodyMedium,
        )));

//Order IDs
const String orderIdTargetElement = 'Target Element';
const String orderIdTooltipText = 'Tooltip Text';
const String orderIdTextSizePadding = 'Text Size_Padding';
const String orderIdTextColor = 'Text Colour';
const String orderIdBgColor = 'Background Colour';
const String orderIdCornerRadTooltipWidth = 'Corner Radius_Tooltip Width';
const String orderIdArrowWidthAndWidth = 'Arrow Width_Arrow Height';
const String orderIdRenderTooltip = 'Render Tooltip';

final List<String> widgetBuildOrder = [
  orderIdTargetElement,
  orderIdTooltipText,
  orderIdTextSizePadding,
  orderIdTextColor,
  orderIdBgColor,
  orderIdCornerRadTooltipWidth,
  orderIdArrowWidthAndWidth,
  orderIdRenderTooltip,
];
