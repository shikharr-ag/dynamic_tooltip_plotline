import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'tooltip_params.freezed.dart';

part 'tooltip_params.g.dart';

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
    required int bgColorCode,
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
          bgColorCode: 0x0,
          tooltipText: '',
          targetElement: '',
        )
      : _$ToolTipParamsFromJson(json);
}
