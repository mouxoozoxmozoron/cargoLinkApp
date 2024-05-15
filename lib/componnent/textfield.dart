import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hintText;
  final bool obseequreText;
  final controller;
  final FormFieldValidator<String>? validator;

  const Mytextfield({
    Key? key, // Define key parameter here
    required this.controller,
    required this.hintText,
    required this.obseequreText,
    required this.validator,
  }) : super(
            key:
                key); // Use super(key: key) to pass key to the superclass constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obseequreText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            fillColor: Colors.grey,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white)),
        validator: validator,
      ),
    );
  }
}
