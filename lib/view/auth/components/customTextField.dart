import 'package:alpha_bookstore/constants/numericVals.dart';
import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final String hintText;
  final bool isSecured;
  final TextEditingController inputvalue;
  const Customtextfield(
      {super.key,
      required this.hintText,
      required this.isSecured,
      required this.inputvalue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldRadius),
          ),
          hintText: hintText),
      obscureText: isSecured,
      controller: inputvalue,
    );
  }
}
