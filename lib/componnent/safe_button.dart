import 'package:cargolink/constants/common_styles.dart';
import 'package:flutter/material.dart';

class SafeButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const SafeButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
            child: Text(
          buttonText,
          style: detailsStyle,
        )),
      ),
    );
  }
}
