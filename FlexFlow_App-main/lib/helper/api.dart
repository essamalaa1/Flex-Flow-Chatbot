import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class API {
  Future<dynamic> get({required String url}) async {
    final http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data >>>>> ${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    final http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed to load data >>>>> ${response.statusCode}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    final http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed to load data >>>>> ${response.statusCode}');
    }
  }
}
