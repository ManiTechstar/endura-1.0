import 'dart:convert';

import 'package:fieldapp/core/base/services/base_http_client.dart';

class AnalysisFormProvider extends BaseHttpClient {
  Future<String> submitAnalysisForm({params}) async {
    final response =
        await post('/analysis_form/insert_analysis_form', body: params);
    final responseBody = jsonDecode(response.body);
    return responseBody['message'];
  }
}
