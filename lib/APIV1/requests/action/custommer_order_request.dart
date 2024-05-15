import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/models/cutommer_order_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Getcustomerorderrequest {
  static Future<ApiResponse> getcustomerorder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    ApiResponse apiResponse = ApiResponse();
    try {
      // Make POST request to the registration endpoint
      final response = await http.get(
        Uri.parse(custommerorderEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          apiResponse.data = custommerorderFromJson(response.body);
          print(apiResponse.data);
          break;
        case 404:
          final errors = jsonDecode(response.body);
          apiResponse.error = errors[errors.keys.elementAt(0)];
          break;
        default:
          apiResponse.error = "please, connect to the internet";
      }
    } catch (e) {
      apiResponse.error = "Something went wrong, try again later";
      // Handle errors
      print('Error: $e');
    }

    return apiResponse;
  }
}
