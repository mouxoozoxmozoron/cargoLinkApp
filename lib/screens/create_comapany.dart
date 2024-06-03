import 'dart:ffi';
import 'dart:io';

import 'package:cargolink/APIV1/end_points/api.dart';
import 'package:cargolink/APIV1/requests/action/create_company.dart';
import 'package:cargolink/componnent/nav_bar.dart';
import 'package:cargolink/componnent/safe_button.dart';
import 'package:cargolink/componnent/textfield.dart';
import 'package:cargolink/constants/widgets.dart';
import 'package:cargolink/navigations/routes_configurations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Createcompany extends StatefulWidget {
  const Createcompany({super.key});

  @override
  State<Createcompany> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<Createcompany> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController backaccountController = TextEditingController();
  final TextEditingController backtypeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController companycategoryController =
      TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController routesController = TextEditingController();
  final TextEditingController workingdayController = TextEditingController();
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

      String name = nameController.text;
      String baacnkaccount = backaccountController.text;
      String banktype = backtypeController.text;
      String location = locationController.text;
      String companycategory = companycategoryController.text;
      String contact = contactController.text;
      String email = emailController.text;
      String routes = routesController.text;
      String workingday = workingdayController.text;
      File? agentlogo = imageFile;

//placeorderRequest
      try {
        ApiResponse response = await createcompanyREequest(
            context,
            name,
            baacnkaccount,
            banktype,
            location,
            companycategory,
            contact,
            email,
            routes,
            workingday,
            agentlogo);

        if (response.error == null) {
          setState(() {
            isPlacingorder = false;
          });
          print(response.error);
          Get.offAllNamed(RoutesClass.gethomeRoute());
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
                    Icons.add_business_sharp,
                    size: 80,
                    color: Colors.pink,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Mytextfield(
                    controller: nameController,
                    hintText: "Comapany name",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Comapny name is requred';
                      }
                      // You can add more validation rules for email format
                      return null;
                    },
                  ),

                  //password
                  Mytextfield(
                    controller: backaccountController,
                    hintText: "Bank account",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bank account is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: backtypeController,
                    hintText: "Bank type",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bank type is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: companycategoryController,
                    hintText: "category",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'category is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: locationController,
                    hintText: "location",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'location is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: contactController,
                    hintText: "contact",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'contact is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: emailController,
                    hintText: "email",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'email is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: routesController,
                    hintText: "routes",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'routes is required';
                      }
                      return null;
                    },
                  ),
                  Mytextfield(
                    controller: workingdayController,
                    hintText: "working day",
                    obseequreText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'working day is required';
                      }
                      return null;
                    },
                  ),

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
                            'set company image',
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
                              errorToast('company logo is required');
                            } else {
                              placeOrderlogic();
                            }
                          },
                          buttonText: 'Create',
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
