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
const String orderIdBgColor = 'Background Colour';
const String orderIdCornerRadTooltipWidth = 'Corner Radius_Tooltip Width';
const String orderIdArrowWidthAndWidth = 'Arrow Width_Arrow Height';
const String orderIdRenderTooltip = 'Render Tooltip';

Map<String, String> tooltipParamsMap = {
  orderIdTargetElement: 'targetElement',
  orderIdTooltipText: 'tooltipText',
  orderIdBgColor: 'bgColorCode',
  orderIdTextColor: 'textColorCode',
  Helper.getSubstrings(orderIdTextSizePadding)[0]: 'textSize',
  Helper.getSubstrings(orderIdTextSizePadding)[1]: 'padding',
  Helper.getSubstrings(orderIdCornerRadTooltipWidth)[0]: 'cornerRadius',
  Helper.getSubstrings(orderIdCornerRadTooltipWidth)[1]: 'tooltipWidth',
  Helper.getSubstrings(orderIdArrowWidthAndWidth)[1]: 'arrowHeight',
  Helper.getSubstrings(orderIdArrowWidthAndWidth)[0]: 'arrowWidth',
};

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
