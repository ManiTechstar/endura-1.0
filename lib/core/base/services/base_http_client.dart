import 'dart:convert';
import 'package:endura_app/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseHttpClient {
  Future<http.Response> get(String path) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    print('URL ==> $apiUrl$path');
    print('TOKEN ==> $token');
    final response = await http.get(
      Uri.parse('$apiUrl$path'),
      headers: {'Authorization': 'Bearer $token'},
    );

    return _handleResponse(response);
  }

  Future<http.Response> post(String path, {Map<String, dynamic>? body}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      print('URL ==> $apiUrl$path');
      print('PARAMS ==> $body');
      print('TOKEN ==> $token');
      final response = await http.post(
        Uri.parse('$apiUrl$path'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }


  Future<http.Response> put(String path, {Map<String, dynamic>? body}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("token");
      print('URL ==> $apiUrl$path');
      print('PARAMS ==> $body');
      print('TOKEN ==> $token');
      final response = await http.put(
        Uri.parse('$apiUrl$path'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  http.Response _handleResponse(http.Response response) {
    print('RESPONSE ==> ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var status = jsonDecode(response.body)["status"];
      if (status == 'SUCCESS') {
        return response;
      } else {
        throw '${jsonDecode(response.body)['message']}';
      }
    } else {
      throw 'API request failed with status code ${response.statusCode}';
    }
  }
}
