import 'dart:convert';
import 'dart:io';
import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> createcompanyREequest(
  BuildContext context,
  String name,
  String baacnkaccount,
  String banktype,
  String location,
  String companycategory,
  String contact,
  String email,
  String routes,
  String workingday,
  File? agentlogo,
) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  ApiResponse apiResponse = ApiResponse();
  try {
    String? base64Image;
    if (agentlogo != null) {
      List<int> imageBytes = await agentlogo.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    final response = await http.post(Uri.parse(creategroupendpoint),
        body: json.encode({
          'name': name,
          'bank_acount_number': baacnkaccount,
          'bank_type': banktype,
          'location': location,
          'company_category': companycategory,
          'contact': contact,
          'email': email,
          'routes': routes,
          'working_day': workingday,
          'agent_logo': base64Image,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 201) {
      successToast("Company created succesfull");
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
      apiResponse.error = 'An error occurred. Please try again later.';
      final errors = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Connection problem $errors'),
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
