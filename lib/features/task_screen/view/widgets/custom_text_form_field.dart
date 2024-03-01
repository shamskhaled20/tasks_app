import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function()? onTap;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey), // Set the hint text color
          filled: true,
          fillColor: Colors.grey[200], // Gray background color
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Remove border
            borderRadius: BorderRadius.circular(20), // Add border radius
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 33 / 2 - 10),
        ),
      ),
    );
  }
}
