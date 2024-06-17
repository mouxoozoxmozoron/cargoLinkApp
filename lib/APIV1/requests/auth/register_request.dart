import 'dart:convert';
import 'dart:io';
import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> createaccountREequest(
  BuildContext context,
  String fname,
  String lname,
  String phonenumber,
  String email,
  String password,
  File? profilephoto,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String? base64Image;
    if (profilephoto != null) {
      List<int> imageBytes = await profilephoto.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    final response = await http.post(Uri.parse(createaccountendpoint),
        body: json.encode({
          'first_name': fname,
          'last_name': lname,
          'email': email,
          'password': password,
          'phone_number': phonenumber,
          'profile_image': base64Image,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 201) {
      successToast("Account created succesfull");
      apiResponse.error = null;
    } else if (response.statusCode == 422) {
      final Map<String, dynamic> errors = jsonDecode(response.body);
      apiResponse.error = errors['message'] ?? 'Validation error';
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> errors = jsonDecode(response.body);
      apiResponse.error = errors['message'] ?? 'Validation error';
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
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> errors = jsonDecode(response.body);
      apiResponse.error = errors['message'] ?? 'Unauthorized';
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Authorization Error'),
            content: Text(apiResponse.error!),
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
    } else {
      final Map<String, dynamic> errors = jsonDecode(response.body);
      apiResponse.error = 'An error occurred: ${errors['message']}';
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
    errorToast('Error: $e');
    print('Error: $e');
    throw Exception('An error occurred. Please try again later $e.');
  }
}
