import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import '../../application/tooltip/preview_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bubble_shape.dart';

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
    image: AssetImage('assets/Icon/error.png'),
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
    {bool isBottom = false,
    bool isRight = false,
    bool isLeft = false,
    bool isCenter = false}) {
  // log('Target $target ... bot $isBottom R: $isRight L:$isLeft');

  return Consumer<PreviewPageProvider>(builder: (context, p, _) {
    return Tooltip(
        key: p.key,
        richMessage: WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: ConstrainedBox(
            key: p.constraintsKey,
            constraints: BoxConstraints(
              maxWidth: p.getCorrectedTooltipWidth(),
              minWidth: p.getCorrectedTooltipWidth(),
              minHeight: p.getTooltipHeight(),
            ),
            child: AutoSizeText(
              p.getTooltipMessage(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: bodyMedium.copyWith(
                color: p.getTextColor(),
                fontSize: p.getTextSize(),
              ),
            ),
          ),
        ),
        triggerMode: TooltipTriggerMode.manual,
        padding: EdgeInsets.all(
          p.getTooltipPadding(),
        ),
        verticalOffset: p.getTooltipVerticalOffset(),
        margin:
            p.getMargin(isRight: isRight, isCenter: isCenter, isLeft: isLeft),
        decoration: ShapeDecoration(
          shape: BubbleShape(
            preferredDirection: p.getToolDirection(isBottom),
            target: p.getDynamicOffset(isBottom,
                isCenter: isCenter, isLeft: isLeft, isRight: isRight),
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
  });
}

Widget _buildDynamicButton(
    {required String x,
    required PreviewPageProvider prov,
    bool isBottom = false,
    bool isRight = false,
    bool isLeft = false,
    bool isCenter = false}) {
  return prov.getShowTooltip(x)
      ? _buildTooltipAndTarget(prov, x,
          isBottom: isBottom,
          isLeft: isLeft,
          isCenter: isCenter,
          isRight: isRight)
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
                // flex: 2,
                child: _buildDynamicButton(
                    prov: prov, x: buttonIndices[0], isCenter: true),
              ),
              const Spacer(),
            ]
          : [
              Expanded(
                child: _buildDynamicButton(
                    prov: prov,
                    x: buttonIndices[0],
                    isBottom: isBottom,
                    isLeft: true),
              ),
              const Spacer(),
              Expanded(
                  child: _buildDynamicButton(
                      prov: prov,
                      x: buttonIndices[1],
                      isBottom: isBottom,
                      isRight: true))
            ]);
}
