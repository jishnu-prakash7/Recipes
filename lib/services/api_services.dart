import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:recipes_app/models/data_model.dart';

class ApiServices {
  final String baseUrl =
      'https://fls8oe8xp7.execute-api.ap-south-1.amazonaws.com/dev/nosh-assignment';

  static var client = http.Client();

  Future<List<DataModel>> getRecipeDatas() async {
    Response response = await client.get(Uri.parse(baseUrl));
    debugPrint('Status code is :${response.statusCode}');
    if (response.statusCode == 200) {
      List responseData = jsonDecode(response.body);
      return responseData.map((data) => DataModel.fromJson(data)).toList();
    } else if (response.statusCode == 404) {
      throw Exception('Data not found');
    } else if (response.statusCode == 500) {
      throw Exception('Internal Server Error');
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}

final dataProvider = Provider<ApiServices>((ref) => ApiServices());
