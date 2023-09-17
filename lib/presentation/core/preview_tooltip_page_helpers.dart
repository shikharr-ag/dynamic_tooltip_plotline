import 'dart:io';

import 'package:dynamic_tooltip_plotline/application/tooltip/preview_page_provider.dart';
import 'package:flutter/material.dart';

import 'bubble_shape.dart';
import 'build_helper_widgets.dart';
import 'style_elements.dart';

DecorationImage _showUrlImage(PreviewPageProvider p) {
  return DecorationImage(
      image: NetworkImage(p.getImageUrl()!),
      onError: (exception, stackTrace) => p.setErrorForNetworkImage());
}

DecorationImage showImage(PreviewPageProvider p) {
  return p.hasUrl() ? _showUrlImage(p) : _showFileImage(p);
}

DecorationImage showError() {
  return const DecorationImage(
    image: AssetImage('assets/Logo/dynamite.jpeg'),
  );
}

DecorationImage _showFileImage(PreviewPageProvider p) {
  return DecorationImage(
    image: FileImage(
      File(p.getFilePath()!),
    ),
  );
}

Widget _buildTooltipAndTarget(PreviewPageProvider p, String target,
    {bool isBottom = false}) {
  GlobalKey<TooltipState> k = p.getGlobalKeyForTooltip(target);

  ///This gives time for tooltip to get built and gets its state
  Future.delayed(const Duration(milliseconds: 100)).then((_) {
    p.showTooltipForKey(k);
  });
  return Tooltip(
      key: k,
      message: p.getTooltipMessage(),
      padding: EdgeInsets.symmetric(horizontal: p.getTooltipWidth()),
      height: p.getTooltipPadding(),
      verticalOffset: p.getTooltipVerticalOffset(),
      margin: EdgeInsets.zero,
      decoration: ShapeDecoration(
        shape: BubbleShape(
          preferredDirection: p.getToolDirection(isBottom),
          target: p.getDynamicOffset(isBottom),
          borderRadius: p.getBorderRadius(),
          arrowBaseWidth: p.getArrowBaseWidth(),
          arrowTipDistance: p.getArrowBaseHeight(),
          borderColor: p.getTooltipColor() ?? borderColor,
          borderWidth: 2,
        ),
        color: p.getTooltipColor(),
        image: p.showTooltipImage()
            ? p.errorInNetworkImage
                ? showError()
                : showImage(p)
            : null,
      ),
      child: _buildTooltipButton(x: target));
}

Widget _buildDynamicButton(
    {required String x,
    required PreviewPageProvider prov,
    bool isBottom = false}) {
  return prov.getShowTooltip(x)
      ? _buildTooltipAndTarget(prov, x, isBottom: isBottom)
      : _buildTooltipButton(x: x);
}

Widget _buildTooltipButton({required String x}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: myRad, side: myBorder.borderSide),
    ),
    child: Text(
      x,
      style: bodyMedium,
    ),
  );
}

Widget buildMyRow({
  required List<String> buttonIndices,
  required PreviewPageProvider prov,
  bool isCenter = false,
  bool isTop = false,
  bool isBottom = false,
}) {
  return Row(
      children: isCenter
          ? [
              const Spacer(),
              Expanded(
                flex: 2,
                child: _buildDynamicButton(prov: prov, x: buttonIndices[0]),
              ),
              const Spacer(),
            ]
          : [
              Expanded(
                child: _buildDynamicButton(
                    prov: prov, x: buttonIndices[0], isBottom: isBottom),
              ),
              const Spacer(),
              Expanded(
                  child: _buildDynamicButton(
                      prov: prov, x: buttonIndices[1], isBottom: isBottom))
            ]);
}
