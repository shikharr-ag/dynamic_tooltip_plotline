import 'package:dynamic_tooltip_plotline/domain/tooltip/tooltip_params.dart';

import 'helper.dart';

/// 5 buttons
final List<String> buttons = List.generate(
  5,
  (index) => 'Button ${index + 1}',
);

//Order IDs
const String orderIdTargetElement = 'Target Element';
const String orderIdTooltipText = 'Tooltip Text';
const String orderIdTextSizePadding = 'Text Size_Padding';
const String orderIdTextColor = 'Text Colour';
const String orderIdBgColor = 'Background Style';
const String orderIdCornerRadTooltipWidth = 'Corner Radius_Tooltip Width';
const String orderIdArrowWidthAndWidth = 'Arrow Width_Arrow Height';
const String orderIdRenderTooltipAndPreviousStyle =
    'Render Tooltip_Fill Last Style';

Map<String, String> tooltipParamsMap = {
  orderIdTargetElement: targetElementJsonKey,
  orderIdTooltipText: tooltipTextJsonKey,
  orderIdBgColor: bgSrcJsonKey,
  orderIdTextColor: textColorCodeJsonKey,
  Helper.getSubstrings(orderIdTextSizePadding)[0]: textSizeJsonKey,
  Helper.getSubstrings(orderIdTextSizePadding)[1]: paddingJsonKey,
  Helper.getSubstrings(orderIdCornerRadTooltipWidth)[0]: cornerRadiusJsonKey,
  Helper.getSubstrings(orderIdCornerRadTooltipWidth)[1]: tooltipWidthJsonKey,
  Helper.getSubstrings(orderIdArrowWidthAndWidth)[1]: arrowHeightJsonKey,
  Helper.getSubstrings(orderIdArrowWidthAndWidth)[0]: arrowWidthJsonKey,
};

final List<String> widgetBuildOrder = [
  orderIdTargetElement,
  orderIdTooltipText,
  orderIdTextSizePadding,
  orderIdTextColor,
  orderIdBgColor,
  orderIdCornerRadTooltipWidth,
  orderIdArrowWidthAndWidth,
  orderIdRenderTooltipAndPreviousStyle,
];
