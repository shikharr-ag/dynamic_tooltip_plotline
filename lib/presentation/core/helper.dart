import 'dart:developer';

import 'package:dynamic_tooltip_plotline/domain/tooltip/tooltip_params.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';

import '../../domain/core/failures.dart';

class Helper {
  static List<String> getSubstrings(String s) {
    return s.split('_');
  }

  static String getJsonKeyFromHeadline(String headline) {
    log('Headline: $headline');
    return tooltipParamsMap[headline]!;
  }

  static String getErrorMessage(ValueFailure f) {
    return f.map(
        none: (_) => '',
        incompleteForm: (_) => 'Please fill all the fields.',
        empty: (_) => 'Empty Textfield',
        negativeDouble: (_) => 'Invalid Numeric Value Entered.',
        invalidPhotoUrl: (_) => '',
        invalidColor: (_) => 'Invalid Color selected.');
  }

  static Map<String, Object> convertToUsableForm(Map<String, dynamic> m) {
    Map<String, Object> x = {};
    m.forEach((key, value) {
      if (key == textColorCodeJsonKey) {
        x.update(key, (value) => int.parse(value.toString()),
            ifAbsent: () => int.parse(value.toString()));
      } else if (key == bgSrcJsonKey ||
          key == tooltipTextJsonKey ||
          key == targetElementJsonKey) {
        x.update(key, (value) => value.toString(),
            ifAbsent: () => value.toString());
      } else {
        x.update(key, (value) => double.parse(value.toString()),
            ifAbsent: () => double.parse(value.toString()));
      }
    });
    return x;
  }
}
