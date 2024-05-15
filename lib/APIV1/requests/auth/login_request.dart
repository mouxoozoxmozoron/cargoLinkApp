import 'dart:convert';
import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/end_points/api_end_points.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> loginrequest(
    BuildContext context, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginEndpoint),
        body: json.encode({'email': email, 'password': password}),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

    if (response.statusCode == 200) {
      // apiResponse.success = true;
      apiResponse.data = loginFromJson(response.body);
    } else if (response.statusCode == 401) {
      final errors = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('incorrect email or password.'),
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


// else {
//         // ignore: use_build_context_synchronously
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Invalid response from server.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }

//     else {
//       // ignore: use_build_context_synchronously
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to login. Please try again.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }

// catch (e) {
//   print('Error: $e');
//   // ignore: use_build_context_synchronously
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Error'),
//         content: Text('An error occurred. Please try again later.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }
