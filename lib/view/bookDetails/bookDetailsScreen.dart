import 'package:alpha_bookstore/constants/numericVals.dart';
import 'package:alpha_bookstore/controller/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bookdetailsscreen extends StatefulWidget {
  const Bookdetailsscreen({super.key});

  @override
  State<Bookdetailsscreen> createState() => _BookdetailsscreenState();
}

class _BookdetailsscreenState extends State<Bookdetailsscreen> {
  @override
  Widget build(BuildContext context) {
    final selectedBook = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xffEF5A5A),
                  size: 35,
                )),
          )
        ],
      ),
      body: Container(
        width: 500,
        padding: EdgeInsets.all(paddingPage),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: 300,
                  width: 250,
                  child: PageView.builder(
                    itemCount: selectedBook["bookImgs"].length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image:
                                NetworkImage(selectedBook["bookImgs"][index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    selectedBook["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  selectedBook["authorName"],
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: 500,
                  child: const Text(
                    "Overview",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Text(selectedBook["description"],
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[700])),
                  ),
                ),
              ],
            ),
            GetBuilder<Cartcontroller>(
                init: Cartcontroller(),
                builder: (controller) => Container(
                    width: 500,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: controller.cart.any(
                                (item) => item["bookID"] == selectedBook["id"])
                            ? Colors.grey
                            : Color(0xffEF5A5A)),
                    child: controller.cart
                            .any((item) => item["bookID"] == selectedBook["id"])
                        ? TextButton(
                            onPressed: () {
                              var selectedElement = controller.cart.firstWhere(
                                (ele) => ele["bookID"] == selectedBook["id"],
                                // Handle the case where no element is found
                              );

                              if (selectedElement != null) {
                                controller
                                    .removeFromCart(selectedElement["id"]);
                                // print(selectedElement);
                              } else {
                                print("No matching element found in the cart");
                              }
                            },
                            child: const Text(
                              "Remove from Cart",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ))
                        : TextButton(
                            onPressed: () {
                              controller.addToCart(selectedBook["id"]);
                            },
                            child: const Text(
                              "Add to Cart ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ))))
          ],
        ),
      ),
    );
  }
}
