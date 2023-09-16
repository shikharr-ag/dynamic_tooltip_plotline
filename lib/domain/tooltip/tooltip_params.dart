import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'tooltip_params.freezed.dart';

part 'tooltip_params.g.dart';

//Tooltip Json Keys
/// UPDATE THESE ACCORDING TO THE NAME OF THE VARIABLES
/// IF ANY CHANGES ARE MADE
const String arrowWidthJsonKey = 'arrowWidth';
const String arrowHeightJsonKey = 'arrowHeight';
const String cornerRadiusJsonKey = 'cornerRadius';
const String tooltipWidthJsonKey = 'tooltipWidth';
const String paddingJsonKey = 'padding';
const String textSizeJsonKey = 'textSize';
const String textColorCodeJsonKey = 'textColorCode';
const String bgSrcJsonKey = 'bgSrc';
const String tooltipTextJsonKey = 'tooltipText';
const String targetElementJsonKey = 'targetElement';

@freezed
class ToolTipParams with _$ToolTipParams {
  const factory ToolTipParams({
    required double arrowWidth,
    required double arrowHeight,
    required double cornerRadius,
    required double tooltipWidth,
    required double padding,
    required double textSize,
    required int textColorCode,
    required String bgSrc,
    required String tooltipText,
    required String targetElement,
  }) = _ToolTipParams;

  // ToolTipParams init = const ToolTipParams(
  //   arrowHeight: 0.0,
  //   arrowWidth: 0.0,
  //   cornerRadius:0,
  //   tooltipWidth:0,
  //   padding:0,
  //   textSize:0,
  //   textColorCode:0x0,
  //   bgColorCode:0x0,
  //   tooltipText:'',
  //   targetElement:'',
  // );

  factory ToolTipParams.fromJson(Map<String, Object?> json) => json.isEmpty
      ? const ToolTipParams(
          arrowHeight: 0.0,
          arrowWidth: 0.0,
          cornerRadius: 0,
          tooltipWidth: 0,
          padding: 0,
          textSize: 0,
          textColorCode: 0x0,
          bgSrc: '',
          tooltipText: '',
          targetElement: '',
        )
      : _$ToolTipParamsFromJson(json);
}
