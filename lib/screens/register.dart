import 'dart:ffi';
import 'dart:io';

import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/requests/auth/register_request.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/componnent/safe_button.dart';
import 'package:cargolink/componnent/textfield.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Createaccount extends StatefulWidget {
  const Createaccount({super.key});

  @override
  State<Createaccount> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<Createaccount> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  XFile? _image;

  bool isregistering = false;
  bool isImageSelected = false;

  placeOrderlogic() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isregistering = true;
      });

//procesing received data
      File? imageFile;
      if (_image != null) {
        imageFile = File(_image!.path);
      }

      String fname = firstnameController.text;
      String lname = lastnameController.text;
      String phonenumber = phonenumberController.text;
      String email = emailController.text;
      String password = passwordController.text;
      File? profilephoto = imageFile;

//placeorderRequest
      try {
        ApiResponse response = await createaccountREequest(
          context,
          fname,
          lname,
          phonenumber,
          email,
          password,
          profilephoto,
        );

        if (response.error == null) {
          setState(() {
            isregistering = false;
          });
          print(response.error);
          Get.back();
        } else {
          setState(() {
            isregistering = false;
          });
          print(response.error);
        }
      } catch (e) {
        warningToast("Something went wrong $e");
        print("error $e");
      }
    }
    setState(() {
      isregistering = false;
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
                    Icons.account_circle,
                    size: 80,
                    color: Colors.pink,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Mytextfield(
                    controller: firstnameController,
                    hintText: "First name",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'first name is requred';
                      }
                      // You can add more validation rules for email format
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //password
                  Mytextfield(
                    controller: lastnameController,
                    hintText: "Last name",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'last name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Mytextfield(
                    controller: emailController,
                    hintText: "Email",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Mytextfield(
                    controller: phonenumberController,
                    hintText: "Phone number",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Mytextfield(
                    controller: passwordController,
                    hintText: "Password",
                    obseequreText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  _image != null
                      ? ClipOval(
                          child: Container(
                            height: 200,
                            width: 200,
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
                            'set profile image',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),

                  const SizedBox(
                    height: 30,
                  ),

                  isregistering
                      ? const CircularProgressIndicator()
                      : SafeButton(
                          onTap: () {
                            if (_image == null) {
                              errorToast('Profile photo is required');
                            } else {
                              placeOrderlogic();
                            }
                          },
                          buttonText: 'Sign up',
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
