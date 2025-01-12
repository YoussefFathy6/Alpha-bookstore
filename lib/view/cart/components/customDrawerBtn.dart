import 'package:flutter/material.dart';

class Customdrawerbtn extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function method;
  const Customdrawerbtn(
      {super.key,
      required this.icon,
      required this.title,
      required this.method});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          method();
        },
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        ));
  }
}
