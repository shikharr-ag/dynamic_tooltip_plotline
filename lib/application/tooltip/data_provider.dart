import 'dart:developer';

import 'package:dynamic_tooltip_plotline/domain/tooltip/background_style.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/core/failures.dart';

// import '../../domain/tooltip/tooltip_params.dart';

class DataProvider extends ChangeNotifier {
  //Private States
  final Map<String, Object> _styleFactors = {};
  ValueFailure _failure = ValueFailure.none();
  // final ToolTipParams _params = ToolTipParams.fromJson({});
  String _logoUrl = '';
  bool _isFormComplete = false;
  Map<String, Object> get styleFactors => _styleFactors;
  String _targetElementState = '';

  static const String _gallerySrcKey = 'Gallery';
  static const String _logosSrcKey = 'Logos';
  static const String _customSrcKey = 'Custom';

  //Dialog States
  String _backgroundStyleDomainState = '';
  String _backgroundStyleSourceState = '';
  int _backgroundStyleRadioGroupVal = 0;
  final Map<String, String> _backgroundStyleSourceAndHeadlines = {
    _gallerySrcKey: 'Pick from Gallery',
    _logosSrcKey: 'Company Logos',
    _customSrcKey: 'Image URL',
  };
  int _dialogTabIndex = 0;
  String _filePath = '';
  bool _previewImage = false;
  bool _isSrcGallery = false;
  bool _isSrcLogos = false;
  bool _isSrcCustom = false;
  bool _isSrcReady = false;
  int _dialogBgColorCode = 0;
  Color _dialogStateColor = Colors.black;

  //Getters
  String get logoUrl => _logoUrl;
  ValueFailure get failure => _failure;
  bool get isFormComplete => _isFormComplete;
  String get targetElementState => _targetElementState;
  String get backgroundStyleDomainState => _backgroundStyleDomainState;
  String get backgroundStyleSourceState => _backgroundStyleSourceState;
  int get backgroundStyleRadioGroupVal => _backgroundStyleRadioGroupVal;
  Map<String, String> get backgroundStyleSourceAndHeadlines =>
      _backgroundStyleSourceAndHeadlines;
  int get dialogTabIndex => _dialogTabIndex;
  String get filePath => _filePath;
  bool get previewImage => _previewImage;
  bool get isSrcGallery => _isSrcGallery;
  bool get isSrcLogos => _isSrcLogos;
  bool get isSrcCustom => _isSrcCustom;
  bool get isSrcReady => _isSrcReady;
  int get dialogBgColorCode => _dialogBgColorCode;
  Color get dialogStateColor => _dialogStateColor;

  void add(String key, Object val) {
    log('Color $val ');
    String s =
        BackgroundStyle().genTooltipParam(BackgroundStyle(color: val as Color));

    _styleFactors.update(key, (_) => key == orderIdBgColor ? s : val,
        ifAbsent: () => key == orderIdBgColor ? s : val);
    // log('Updated Factors: $_styleFactors');
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

  void setLogoUrl(String url) {
    _logoUrl = url;
    _filePath = '';
    _previewImage = false;
    setSrcReady();
    notifyListeners();
  }

  ///Used to set target element in state
  void setTargetElementState(String s) {
    _targetElementState = s;
    notifyListeners();
  }

  ///Used to set the domain in state
  void setBackgroundStyleDomainSet(String s) {
    _backgroundStyleDomainState = s;
    notifyListeners();
  }

  ///Used to set the source in state
  void setBackgroundStyleSourceState(String s) {
    _backgroundStyleSourceState = s;
    notifyListeners();
  }

  void setBackgroundStyleRadioGroupVal(int val) {
    _backgroundStyleRadioGroupVal = val;
    notifyListeners();
  }

  void updateTabIndex(int i) {
    _dialogTabIndex = i;
    notifyListeners();
  }

  ///Sets file path of file picked from gallery
  void setFilePath(String _) {
    _filePath = _;
    _logoUrl = '';
    _previewImage = false;
    setSrcReady();
    notifyListeners();
  }

  void showImage() {
    _previewImage = true;
    notifyListeners();
  }

  void clearSrcStates() {
    _filePath = _logoUrl = '';
    _previewImage = _isSrcReady = false;
  }

  void setDialogBgColorCode(int x) {
    _dialogBgColorCode = x;
    notifyListeners();
  }

  ///Used to set the source of image
  void setSource(String s) {
    switch (s) {
      case _gallerySrcKey:
        _isSrcGallery = true;
        _isSrcLogos = _isSrcCustom = false;
        break;
      case _customSrcKey:
        _isSrcCustom = true;
        _isSrcGallery = _isSrcLogos = false;
        break;
      case _logosSrcKey:
        _isSrcLogos = true;
        _isSrcGallery = _isSrcCustom = false;
        break;
      default:
        _isSrcLogos = _isSrcGallery = _isSrcCustom = false;
    }
    clearSrcStates();
    log('Updated Source Gal:${_isSrcGallery} Cus:${_isSrcCustom} Log:${_isSrcLogos}');
    notifyListeners();
  }

  void setSrcReady() {
    if ((_isSrcGallery && _filePath.isNotEmpty) ||
        (_isSrcLogos || _isSrcCustom) && (_logoUrl.isNotEmpty)) {
      _isSrcReady = true;
    } else {
      _isSrcReady = false;
    }
  }

  ///Sets the image to tooltip parmams
  void setImage() {
    if (_filePath.isNotEmpty) {
      _styleFactors.update(
          orderIdBgColor,
          (value) => BackgroundStyle()
              .genTooltipParam(BackgroundStyle(src: _filePath, isUrl: false)));
    } else {
      _styleFactors.update(
          orderIdBgColor,
          (value) => BackgroundStyle()
              .genTooltipParam(BackgroundStyle(src: _logoUrl, isUrl: true)));
    }
  }

  void setDialogStateColor(Color c) {
    _dialogStateColor = c;
    notifyListeners();
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
