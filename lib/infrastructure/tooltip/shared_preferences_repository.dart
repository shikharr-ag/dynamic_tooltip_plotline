import 'dart:convert';
import 'dart:developer';

import 'package:dynamic_tooltip_plotline/domain/tooltip/tooltip_params.dart';
import 'package:dynamic_tooltip_plotline/infrastructure/core/prefs_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = SharedPreferencesRepository();

class SharedPreferencesRepository {
  static SharedPreferences? _sharedPreferences;

  init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  void storeStyleFactors(ToolTipParams params) {
    // log('Json String: ${jsonEncode(params.toJson())}');
    // log('Decode: ${jsonDecode(jsonEncode(params.toJson()))}');
    // log('Tooltip Parmas: ${ToolTipParams.fromJson(jsonDecode(jsonEncode(params.toJson())))}');
    _sharedPreferences!
        .setString(previousStyleKey, jsonEncode(params.toJson()));
  }

  Map<String, dynamic> getStyleFactors() {
    String s = _sharedPreferences!.getString(previousStyleKey) ?? '';
    log('Got S: $s');
    return s.isEmpty ? {} : jsonDecode(s);
  }

  bool checkIfDataExists() {
    return _sharedPreferences!.containsKey(previousStyleKey);
  }
}
