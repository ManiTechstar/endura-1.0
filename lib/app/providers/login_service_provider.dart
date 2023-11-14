import 'dart:convert';

import 'package:fieldapp/app/data/model/user_model.dart';
import 'package:fieldapp/core/base/services/base_http_client.dart';
import 'package:fieldapp/core/utilities/shared_preferance_helper.dart';

class LoginServiceProvider extends BaseHttpClient {
  Future<UserModel> login({params}) async {
    try {
      final response = await post('/user/user_login', body: params);

      final responseBody = jsonDecode(response.body);

      UserModel model = UserModel.fromJson(responseBody['result']['user']);
      SharedPreferanceHelper().setSharedPrefString(
          key: 'token', value: responseBody['result']['token']);
      SharedPreferanceHelper()
          .setSharedPrefString(key: 'user', value: json.encode(model));
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
