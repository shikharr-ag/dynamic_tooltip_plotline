// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tooltip_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToolTipParams _$$_ToolTipParamsFromJson(Map<String, dynamic> json) =>
    _$_ToolTipParams(
      arrowWidth: (json['arrowWidth'] as num).toDouble(),
      arrowHeight: (json['arrowHeight'] as num).toDouble(),
      cornerRadius: (json['cornerRadius'] as num).toDouble(),
      tooltipWidth: (json['tooltipWidth'] as num).toDouble(),
      padding: (json['padding'] as num).toDouble(),
      textSize: (json['textSize'] as num).toDouble(),
      textColorCode: json['textColorCode'] as int,
      bgSrc: json['bgSrc'] as String,
      tooltipText: json['tooltipText'] as String,
      targetElement: json['targetElement'] as String,
    );

Map<String, dynamic> _$$_ToolTipParamsToJson(_$_ToolTipParams instance) =>
    <String, dynamic>{
      'arrowWidth': instance.arrowWidth,
      'arrowHeight': instance.arrowHeight,
      'cornerRadius': instance.cornerRadius,
      'tooltipWidth': instance.tooltipWidth,
      'padding': instance.padding,
      'textSize': instance.textSize,
      'textColorCode': instance.textColorCode,
      'bgSrc': instance.bgSrc,
      'tooltipText': instance.tooltipText,
      'targetElement': instance.targetElement,
    };
