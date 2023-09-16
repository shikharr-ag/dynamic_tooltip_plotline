import 'dart:developer';
import 'dart:ui';

class BackgroundStyle {
  final Color? color;
  final String? src;
  final bool isUrl;
  BackgroundStyle({this.color, this.src, this.isUrl = false});

  ///Returns a string based on the object
  String genTooltipParam(BackgroundStyle obj) {
    log('obj : ${obj.isUrl}${obj.color}${obj.src}');
    if (obj.color != null) {
      return "${obj.color!.value}_COLOR";
    } else {
      if (isUrl) {
        return obj.src!;
      } else {
        return "${obj.src}_FILE";
      }
    }
  }

  ///Takes formatted string to give BackgroundStyle Object
  BackgroundStyle getObjectFromString(String s) {
    Color? c;
    String? src;
    bool url = false;
    if (s.endsWith("_COLOR")) {
      c = Color(int.parse(s.substring(0, (s.length - "_COLOR".length + 1))));
    } else if (s.endsWith("_FILE")) {
      src = s.substring(0, (s.length - "_FILE".length + 1));
      url = false;
    } else {
      url = true;
      src = s;
    }
    return BackgroundStyle(color: c, isUrl: url, src: s);
  }
}
