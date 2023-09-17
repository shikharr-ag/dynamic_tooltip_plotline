import '../../presentation/core/style_elements.dart';
import 'package:flutter/material.dart';

class DesignPageProvider extends ChangeNotifier {
  bool _isLoading = false;
  BoxConstraints _constraints = BoxConstraints();

  bool get isLoading => _isLoading;
  BoxConstraints get constraints => _constraints;

  void setConstraints(BoxConstraints c) {
    _constraints = c;
  }

  double getTopPadding() {
    return _constraints.maxHeight * 0.05;
  }

  double getBottomPadding() {
    return _constraints.maxHeight * 0.005;
  }

  double getHorizontalPadding() {
    return _constraints.maxWidth * horizontalPaddingFactor;
  }

  double getListViewWidth() {
    return _constraints.maxWidth - 2 * getHorizontalPadding();
  }

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setLoaded() {
    _isLoading = false;
    notifyListeners();
  }
}
