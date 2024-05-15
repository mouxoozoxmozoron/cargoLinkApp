import 'dart:convert';
import 'dart:io';
import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> placeorderRequest(BuildContext context, String destination,
    String quantity, File? cargoImage, int transporatationcompnayId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  ApiResponse apiResponse = ApiResponse();
  try {
    String? base64Image;
    if (cargoImage != null) {
      List<int> imageBytes = await cargoImage.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    final response = await http.post(Uri.parse(placeorderendPoint),
        body: json.encode({
          'destination': destination,
          'quantity': quantity,
          'transportation_companies_id': transporatationcompnayId,
          'cargo_image': base64Image,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 201) {
      successToast("Order placed succesfull");
    } else if (response.statusCode == 422) {
      final errors = jsonDecode(response.body);
      print("error: $errors");
    } else if (response.statusCode == 401) {
      final errors = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Not loged in.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      apiResponse.error = errors[errors.keys.elementAt(0)];
    } else {
      // Handle other status codes if needed
      // apiResponse.success = false;
      apiResponse.error = 'An error occurred. Please try again later.';
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Connection problem.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    // Return the ApiResponse object
    return apiResponse;
  } catch (e) {
    print('Error: $e');
    // Throw an error or return an ApiResponse object with error details
    throw Exception('An error occurred. Please try again later.');
  }
}
