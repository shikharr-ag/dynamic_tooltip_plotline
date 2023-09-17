import 'dart:developer';

import 'package:dynamic_tooltip_plotline/domain/tooltip/background_style.dart';
import 'package:dynamic_tooltip_plotline/domain/tooltip/tooltip_params.dart';
import 'package:dynamic_tooltip_plotline/presentation/core/bubble_shape.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../presentation/core/style_elements.dart';

class PreviewPageProvider extends ChangeNotifier {
  bool _errorInNetworkImage = false;

  ToolTipParams _params = ToolTipParams.fromJson({});
  BoxConstraints _pageConstraints = BoxConstraints();

  //Getters
  bool get errorInNetworkImage => _errorInNetworkImage;
  ToolTipParams get params => _params;

  void setPageConstraints(BoxConstraints c) {
    _pageConstraints = c;
  }

  bool getShowTooltip(String x) {
    log('$x  ${_params.targetElement}');
    log('Get tooltip for ${x == _params.targetElement}');
    return x == _params.targetElement;
  }

  void setErrorForNetworkImage() {
    _errorInNetworkImage = true;
    notifyListeners();
  }

  void setParamState(ToolTipParams p) {
    log('Set params: $p');
    _params = p;
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

  double getMaxWidth() {
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

  Offset getDynamicOffset(bool isBottom) {
    Offset f = Offset(
        getArrowBaseWidth() + getTooltipWidth()
        // getTooltipWidth() + getArrowBaseWidth()
        ,
        isBottom
            ? (getTooltipPadding() +
                    getTooltipVerticalOffset() -
                    getArrowBaseHeight()) -
                5
            // (_tooltipOffsetHeight() +
            //     getTooltipVerticalOffset() +
            //     getArrowBaseHeight())
            : -(_tooltipOffsetHeight()));
    return f;
  }

  double getTooltipPadding() {
    return _params.padding;
  }

  double getTooltipWidth() {
    return _params.tooltipWidth;
  }

  double getTooltipVerticalOffset() {
    return getArrowBaseHeight() + 25;
  }

  double getTooltipMarginLeft(double width) {
    return (width / 3) / 3;
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

  GlobalKey<TooltipState> getGlobalKeyForTooltip(String x) {
    return GlobalKey<TooltipState>(debugLabel: x);
  }
}
