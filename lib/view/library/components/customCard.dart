import 'package:flutter/material.dart';

class Customcard extends StatelessWidget {
  final String img;
  final String title;
  final String author;
  final Function method;
  const Customcard(
      {super.key,
      required this.img,
      required this.title,
      required this.author,
      required this.method});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        method();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 200,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 240,
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      img,
                      fit: BoxFit.fill,
                    ))),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              author,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
