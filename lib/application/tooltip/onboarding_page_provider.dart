import 'package:flutter/material.dart';

class OnboardingStateProvider extends ChangeNotifier {
  bool _hasError = true;
  int _pages = 3;
  int _currentIndex = 0;
  bool _onboardingOver = false;
  bool get hasError => _hasError;
  int get currentIndex => _currentIndex;
  int get pages => _pages;
  void setError(bool f) {
    _hasError = f;
    notifyListeners();
  }

  void setOnboardingOver() {
    _onboardingOver = true;
    notifyListeners();
  }

  void setCurrentIndex(int i) {
    _currentIndex = i;
    notifyListeners();
  }

  void setNextPage() {
    _currentIndex += 1;
    if (_currentIndex > _pages) {
      setOnboardingOver();
    } else {
      notifyListeners();
    }
  }
}
