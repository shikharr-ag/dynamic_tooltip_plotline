import 'dart:developer';

import 'my_double.dart';
import 'tooltip_params.dart';
import 'package:flutter/material.dart';

import 'background_style.dart';

class Convertor {
  final String jsonKey;
  Convertor({
    required this.jsonKey,
  });

  String getReadableString(Map<String, Object> map, {bool isUrl = false}) {
    Object? j = map[jsonKey];
    if (j != null) {
      if (jsonKey == arrowWidthJsonKey ||
          jsonKey == arrowHeightJsonKey ||
          jsonKey == cornerRadiusJsonKey ||
          jsonKey == tooltipWidthJsonKey ||
          jsonKey == paddingJsonKey ||
          jsonKey == textSizeJsonKey) {
        return MyDouble.getPrecisionDouble(j.toString());
      } else if (jsonKey == tooltipTextJsonKey ||
          jsonKey == targetElementJsonKey ||
          jsonKey == bgSrcJsonKey) {
        if (jsonKey == bgSrcJsonKey) {
          log('Bg OBJ : $j ... isURL:$isUrl');
          return BackgroundStyle.getCorrectSrc(j.toString(), isUrl: isUrl);
        }
        return j.toString();
      } else {
        return j.toString();
      }
    } else {
      return '';
    }
  }

  Color? getColor(Map<String, Object> map) {
    Object? j = map[jsonKey];

    if (jsonKey == textColorCodeJsonKey) {
      return j == null ? null : Color(int.parse(j.toString()));
    } else if (jsonKey == bgSrcJsonKey) {
      BackgroundStyle obj = BackgroundStyle().getObjectFromString(j.toString());
      return obj.color ?? Colors.white;
    }
    return Colors.white;
  }
}
