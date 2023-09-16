import 'dart:developer';

import 'package:dynamic_tooltip_plotline/infrastructure/core/api_call_constants.dart';
import 'package:http/http.dart' as http;

class LogoAPIRepository {
  String getUri(String company) {
    String url = APICallConsts.logoUrl;
    String domain = APICallConsts.companyAndDomains[company] ?? 'google.com';
    return url + domain;
  }
}
