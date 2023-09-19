import 'dart:developer';

import '../../domain/tooltip/background_style.dart';
import '../../domain/tooltip/tooltip_params.dart';
import '../../presentation/core/bubble_shape.dart';
import 'package:flutter/material.dart';

import '../../presentation/core/style_elements.dart';

class PreviewPageProvider extends ChangeNotifier {
  bool _errorInNetworkImage = false;

  ToolTipParams _params = ToolTipParams.fromJson({});
  BoxConstraints _pageConstraints = BoxConstraints();
  GlobalKey<TooltipState>? _key;
  double _runtimeHeight = 0;
  final GlobalKey? _constraintsKey = GlobalKey(debugLabel: 'Constraints');
  //Getters
  bool get errorInNetworkImage => _errorInNetworkImage;
  ToolTipParams get params => _params;
  GlobalKey<TooltipState>? get key => _key;
  GlobalKey? get constraintsKey => _constraintsKey;

  void setPageConstraints(BoxConstraints c) {
    _pageConstraints = c;
  }

  bool getShowTooltip(String x) {
    // log('$x  ${_params.targetElement}');
    // log('Get tooltip for ${x == _params.targetElement}');
    return x == _params.targetElement;
  }

  void setErrorForNetworkImage() {
    _errorInNetworkImage = true;
    notifyListeners();
  }

  Size getCurrentConstraints() {
    return _constraintsKey!.currentContext!.size!;
  }

  void setParamState(ToolTipParams p) {
    // log('Set params: $p');
    _params = p;
  }

  double getTooltipHeight() {
    return 16;
  }

  void setRuntimeHeight(double h) {
    _runtimeHeight = h;
    log('Runtime Height: $h');
    notifyListeners();
  }

  double _getMaxWidth() {
    return _pageConstraints.maxWidth;
  }

  double getHorizontalPadding() {
    return _pageConstraints.maxWidth * horizontalPaddingFactor;
  }

  double getVerticalPadding() {
    return _pageConstraints.maxHeight * 0.02;
  }

  double getTotalWidgetHeight() {
    return _pageConstraints.maxHeight * 0.38;
  }

  double getPaddedWidth() {
    return _pageConstraints.maxWidth - (2 * getHorizontalPadding());
  }

  TooltipDirection getToolDirection(bool isBottom) {
    return isBottom ? TooltipDirection.up : TooltipDirection.down;
  }

  double _tooltipOffsetHeight() {
    return getArrowBaseHeight() * 2;
  }

  void showTooltipForKey(GlobalKey<TooltipState> key) {
    key.currentState!.ensureTooltipVisible();
  }

  double _getTooltipMarginOffset() {
    return 10.0;
  }

  double _getMargin() {
    return _checkTooltipWidthOverflow()
        ? _getTooltipMarginOffset()
        : _calcMargin();
  }

  bool _checkTooltipWidthOverflow() {
    return _calcMargin() < _getTooltipMarginOffset() ? true : false;
  }

  double _calcMargin() {
    return _getMaxWidth() - (_getTooltipWidth() + _getTooltipMarginOffset());
  }

  EdgeInsetsGeometry getMargin(
      {bool isLeft = false, bool isRight = false, bool isCenter = false}) {
    // log('Tooltip Width: ${_getTooltipWidth()}  Margin computed Width: ${(_getMaxWidth() - _getTooltipWidth() - _getTooltipMarginOffset())}');
    // log('Max width: ${_getMaxWidth()}');

    return isCenter
        ? EdgeInsets.only(right: _getMargin() / 2, left: _getMargin() / 2)
        : isLeft
            ? EdgeInsets.only(
                right: _getMargin(), left: _getTooltipMarginOffset())
            : EdgeInsets.only(
                left: _getMargin(), right: _getTooltipMarginOffset());
  }

  double _getHorizontalOffset(
      {bool isCenter = false, bool isLeft = false, bool isRight = false}) {
    return isCenter
        ? _getMaxWidth() / 2
        : isRight
            ? ((_getMargin() +
                    getCorrectedTooltipWidth() +
                    _getTooltipMarginOffset()) -
                (getPaddedWidth() / 6 + getHorizontalPadding()))
            : ((getPaddedWidth() / 6 + getHorizontalPadding()));
  }

  double _getRuntimeHeightOrDefault() {
    return _runtimeHeight == 0 ? getTooltipHeight() : _runtimeHeight;
  }

  double _getVerticalOffset(bool isBottom) {
    //Factor of 1.789 calculated from trial
    return isBottom
        ? (_runtimeHeight +
            getArrowBaseHeight() * 1.789
            // ((_getRuntimeHeightOrDefault() + getArrowBaseHeight()) /
            //     // getArrowBaseHeight()
            //     _getRuntimeHeightOrDefault())
            +
            getTooltipVerticalOffset())
        : -(_tooltipOffsetHeight());
  }

  Offset getDynamicOffset(bool isBottom,
      {bool isCenter = false, bool isLeft = false, bool isRight = false}) {
    //Sets the arrow target to middle of the button
    //width of each button is paddedWidth / 3 and this targets its center
    Offset f = Offset(
        _getHorizontalOffset(
            isCenter: isCenter, isLeft: isLeft, isRight: isRight),
        _getVerticalOffset(isBottom));
    return f;
  }

  double getTooltipPadding() {
    return _params.padding;
  }

  double getCorrectedTooltipWidth() {
    return _checkTooltipWidthOverflow()
        ? _getMaxWidth() - _getTooltipMarginOffset()
        : _getTooltipWidth();
  }

  double _getTooltipWidth() {
    return _params.tooltipWidth;
  }

  double getTooltipVerticalOffset() {
    return getArrowBaseHeight() + 25;
  }

  double getTooltipMarginLeft(double width) {
    return (width / 3) / 3;
  }

  Color getTextColor() {
    return Color(_params.textColorCode);
  }

  double getBorderRadius() {
    return _params.cornerRadius;
  }

  double getArrowBaseWidth() {
    return _params.arrowWidth;
  }

  double getArrowBaseHeight() {
    return _params.arrowHeight;
  }

  String getTooltipMessage() {
    return _params.tooltipText;
  }

  Color? getTooltipColor() {
    return BackgroundStyle().getObjectFromString(_params.bgSrc).color;
  }

  String? getImageUrl() {
    return BackgroundStyle().getObjectFromString(_params.bgSrc).src;
  }

  String? getFilePath() {
    return BackgroundStyle().getFilePath(_params.bgSrc);
  }

  bool showTooltipImage() {
    return getTooltipColor() == null ? true : false;
  }

  bool hasUrl() {
    return BackgroundStyle().getObjectFromString(_params.bgSrc).isUrl;
  }

  String getTargetElement() {
    return _params.targetElement;
  }

  GlobalKey<TooltipState> getAndSetGlobalKeyForTooltip(String x) {
    return _key = GlobalKey<TooltipState>(debugLabel: x);
  }

  double getTextSize() {
    return _params.textSize;
  }
}
