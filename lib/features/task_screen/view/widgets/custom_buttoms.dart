import 'package:flutter/material.dart';

// ignore: must_be_immutable
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({
    Key? key,
    required this.onPress,
    required this.title,
    required this.buttonColor,
    required this.buttonBackgroundColor,
    this.borderRadius = 10, // Default border radius
    this.heightButtom =51
  }) : super(key: key);

  final VoidCallback onPress;
  final String title;
  final Color buttonColor;
  final Color buttonBackgroundColor;
  final double borderRadius; // Customizable border radius
  final double heightButtom ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightButtom,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonBackgroundColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius), // Use custom or default border radius
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: buttonColor,
          ),
        ),
      ),
    );
  }
}
