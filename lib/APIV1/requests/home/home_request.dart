import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/models/home_model.dart';
import 'package:http/http.dart' as http;

class Getcompaniesrequest {
  static Future<ApiResponse> getCompanies() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      // Make POST request to the registration endpoint
      final response = await http.get(
        Uri.parse(homeEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          apiResponse.data = companyFromJson(response.body);
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
