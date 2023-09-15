import 'dart:developer';

import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/core/failures.dart';

// import '../../domain/tooltip/tooltip_params.dart';

class DataProvider extends ChangeNotifier {
  final Map<String, Object> _styleFactors = {};
  ValueFailure _failure = ValueFailure.none();
  // final ToolTipParams _params = ToolTipParams.fromJson({});
  bool _isFormComplete = false;
  Map<String, Object> get styleFactors => _styleFactors;
  ValueFailure get failure => _failure;
  bool get isFormComplete => _isFormComplete;

  void add(String key, Object val) {
    log('Adding for $key the value $val');
    _styleFactors.update(key, (key) => val, ifAbsent: () => val);
    log('Updated Factors: $_styleFactors');
    _setNoErrorState();
    notifyListeners();
  }

  void updateValueFailure(ValueFailure f) {
    log('Caught Value Failure: $f');
    _failure = f;
    notifyListeners();
  }

  ///Reinitialise Error State
  void _setNoErrorState() {
    _failure = ValueFailure.none();
  }

  bool checkIfValueAbsent(String id) {
    log('ID Recv: $id');
    _isFormComplete = true;
    bool state = _styleFactors.containsKey(tooltipParamsMap[id]);

    if (!state) {
      _isFormComplete = false;
    }
    return state;
  }

  // void setParams(ToolTipParams params) {
  //   _params = params;
  // }

  // /// Removes all items from the cart.
  // void removeAll() {
  //   _items.clear();
  //   // This call tells the widgets that are listening to this model to rebuild.
  //   notifyListeners();
  // }
}
