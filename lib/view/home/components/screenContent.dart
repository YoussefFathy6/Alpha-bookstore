import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpha_bookstore/controller/bookController.dart';
import 'package:alpha_bookstore/controller/userController.dart';
import 'package:alpha_bookstore/view/home/components/booksSection.dart';

class Screencontent extends StatelessWidget {
  const Screencontent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView(
        children: [
          GetBuilder<Usercontroller>(
            init: Usercontroller(),
            builder: (controller) => controller.user != null
                ? Text(
                    "Hello, ${controller.user[0]['username']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Color(0xffEF5A5A),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Text(
            "What do you want to read today?",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xffEF5A5A),
                ),
                hintText: "Search Here",
              ),
            ),
          ),
          GetBuilder<Bookcontroller>(
            init: Bookcontroller(),
            builder: (controller) => controller.books.isNotEmpty
                ? Bookssection(
                    title: "Latest Books",
                    card: controller.books,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
