import 'package:alpha_bookstore/controller/bookController.dart';
import 'package:alpha_bookstore/view/home/components/customCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bookssection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> card;

  const Bookssection({super.key, required this.title, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "See all",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xffEF5A5A)),
                      ))
                ],
              )),
          card.isNotEmpty // Check if there are books to display
              ? SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: card.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GetBuilder<Bookcontroller>(
                          init: Bookcontroller(),
                          builder: (controller) => Customcard(
                              img: (card[index]["bookImgs"] is List &&
                                      card[index]["bookImgs"].isNotEmpty)
                                  ? card[index]["bookImgs"][0]
                                  : "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/694px-Unknown_person.jpg", // Provide a fallback if the list is empty or not a list
                              title: card[index]["title"],
                              author: card[index]["authorName"],
                              price: card[index]["price"],
                              method: () {
                                controller.bookDetailsNavigation(card[index]);
                              }));
                    },
                  ),
                )
              : const Center(
                  child: Text("No books available."),
                ),
        ],
      ),
    );
  }
}
