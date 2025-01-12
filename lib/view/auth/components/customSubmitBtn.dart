import 'package:flutter/material.dart';

class Customsubmitbtn extends StatelessWidget {
  final String label;
  final Function method;
  const Customsubmitbtn({super.key, required this.label, required this.method});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 500,
      decoration: BoxDecoration(
          color: Color(0xffEF5A5A),
          border: Border(),
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
          onPressed: () {
            method();
          },
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}
