import 'dart:ffi';
import 'dart:io';

import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/requests/action/place_order_request.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/componnent/safe_button.dart';
import 'package:cargolink/componnent/textfield.dart';
import 'package:cargolink/constants/common_styles.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  late String? companyName;
  late int companyId;

  @override
  void initState() {
    super.initState();
    getArgs();
  }

  void getArgs() {
    final args = Get.arguments;

    if (args != null && args is Map<String, dynamic>) {
      companyName = args['companyName'] as String?;
      companyId = args['companyId'] as int? ?? -1;

      print(companyName);
      print(companyId);
      print(args);
    } else {
      print('No argumments available');
      print(args);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  XFile? _image;

  bool isPlacingorder = false;
  bool isImageSelected = false;

  placeOrderlogic() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isPlacingorder = true;
      });

//procesing received data
      File? imageFile;
      if (_image != null) {
        imageFile = File(_image!.path);
      }

      String destination = destinationController.text;
      String quantity = quantityController.text;
      File? cargoImage = imageFile;
      int transporatationcompnayId = companyId;
//placeorderRequest
      try {
        ApiResponse response = await placeorderRequest(context, destination,
            quantity, cargoImage, transporatationcompnayId);

        if (response.error == null) {
          setState(() {
            isPlacingorder = false;
          });
          print(response.error);
          Get.offNamed(RoutesClass.getorderlistrRoute());
        } else {
          setState(() {
            isPlacingorder = false;
          });
          print(response.error);
        }
      } catch (e) {
        warningToast("Something went wrong $e");
        print("error $e");
      }

      print("here from place order page");
      print('placing order with company : $companyName');
      print('placing order witth comaany id : $companyId');
    }
    setState(() {
      isPlacingorder = false;
    });
  }

  void _checkPermissionAndPickImage() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (status.isGranted) {
      _pickImage();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  //logo
                  const Icon(
                    Icons.add_shopping_cart,
                    size: 80,
                    color: Colors.pink,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //text
                  Text(
                    companyName ?? "Unknown company name",
                    style: subtitleStyle,
                  ),

                  // "status":1,
                  // "driver_id":2,
                  // "transportation_companies_id":1,
                  // "quantity":10,
                  //destination

                  const SizedBox(
                    height: 30,
                  ),
                  //text field
                  //email
                  Mytextfield(
                    controller: quantityController,
                    hintText: "Quantity",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the package quantity';
                      }
                      // You can add more validation rules for email format
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //password
                  Mytextfield(
                    controller: destinationController,
                    hintText: "destination",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please, specify destinantion of your package';
                      }
                      // You can add more validation rules for email format
                      return null;
                    },
                  ),
                  //end of text fiels

                  const SizedBox(
                    height: 30,
                  ),

                  _image != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(_image!.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _checkPermissionAndPickImage,
                          child: const Text(
                            'upload package image',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),

                  const SizedBox(
                    height: 30,
                  ),

                  isPlacingorder
                      ? const CircularProgressIndicator()
                      : SafeButton(
                          onTap: () {
                            if (_image == null) {
                              errorToast('Package image is required');
                            } else {
                              placeOrderlogic();
                            }
                          },
                          buttonText: 'Submit Request',
                        ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    thickness: 01,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}







                            // bool isRegistrationLoading = false;
                            // bool userCreated = false;

                            // void _registerWithPermissionCheck() async {
                            // var status = await Permission.storage.status;
                            // if (!status.isGranted) {
                            // await Permission.storage.request();
                            // }
                            // if (status.isGranted && _formKey.currentState!.validate()) {
                            // setState(() {
                            // isRegistrationLoading = true;
                            // });
                            // // File? imageFile = _image != null ? File(_image!.path) : null;
                            // File? imageFile;
                            // if (_image != null) {
                            // imageFile = File(_image!.path);
                            // }
                            // // ignore: use_build_context_synchronously
                            // // ApiResponse response = await RegisterApi.register(
                            // // context,
                            // // _first_nameController.text,
                            // // _last_nameController.text,
                            // // _emailController.text,
                            // // _phoneController.text,
                            // // _passwordController.text,
                            // // imageFile,
                            // // gender,
                            // // );

                            // // if (response.error == null) {
                            // // setState(() {
                            // // isRegistrationLoading = false;
                            // // userCreated = true;
                            // // user = response.data as User;
                            // // });
                            // // //Storing token and user details in local storage
                            // // //IMPORTANT
                            // // final SharedPreferences prefs = await SharedPreferences.getInstance();
                            // // await prefs.setString('token', user!.token);
                            // // await prefs.setInt('userId', user!.data.id);

                            // // final token = prefs.getString('token');

                            // // //navigation to login
                            // // Get.offAllNamed(RoutesClass.getpostsRoute());

                            // // if (userCreated) {
                            // // //paaing variable as an argumment
                            // // successToast(token ?? '');
                            // // }
                            // // }
                            // //else {
                            // // setState(() {
                            // // isRegistrationLoading = false;
                            // // userCreated = false;
                            // // });
                            // // errorToast("hello there");
                            // errorToast("Not connected !");
                            // }
                            // }
