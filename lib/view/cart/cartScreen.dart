import 'package:alpha_bookstore/constants/numericVals.dart';
import 'package:alpha_bookstore/controller/cartController.dart';
import 'package:alpha_bookstore/controller/libraryController.dart';
import 'package:alpha_bookstore/controller/userController.dart';
import 'package:alpha_bookstore/view/cart/components/customPayPalBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Cart",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xffEF5A5A)),
          ),
          actions: [
            GetBuilder<Usercontroller>(
              init: Usercontroller(),
              builder: (controller) => Container(
                margin: const EdgeInsets.only(right: 15),
                width: 40,
                height: 40,
                child: InkWell(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(600),
                    child: controller.user != null
                        ? Image.network(
                            controller.user[0]["profilePic"],
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg",
                            fit: BoxFit.cover),
                  ),
                ),
              ),
            )
          ],
        ),
        body: GetBuilder<Cartcontroller>(
          init: Cartcontroller(),
          builder: (controller) => Container(
            padding: EdgeInsets.all(paddingPage),
            child: controller.cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_shopping_cart_outlined,
                          size: 120,
                          color: Colors.grey[700],
                        ),
                        Text(
                          "Your cart is empty",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            width: 200,
                            decoration: BoxDecoration(
                                color: const Color(0xffEF5A5A),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                                onPressed: () {
                                  Get.offAllNamed("/");
                                },
                                child: Text(
                                  "Go to BookStore",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )))
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: controller.cart.length,
                            itemBuilder: (context, index) => Dismissible(
                              key: Key(controller.cart[index]["id"].toString()),
                              onDismissed: (direction) {
                                controller.removeFromCart(
                                    controller.cart[index]["id"]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Card(
                                  child: ListTile(
                                    title: Text(controller.cart[index]["books"]
                                        ["title"]),
                                    subtitle: Text(
                                        "${controller.cart[index]["books"]["price"].toString()} \$"),
                                    trailing: SizedBox(
                                      width: 50,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          controller.cart[index]["books"]
                                              ["bookImgs"][0],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            // TextButton(
                            //     onPressed: () {
                            //       print(controller.cart);
                            //     },
                            //     child: Text("test btn")),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text("${controller.total.toString()} \$",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                            GetBuilder<Librarycontroller>(
                              init: Librarycontroller(),
                              builder: (controller) => Custompaypalbtn(
                                total: controller.total,
                                method: () {
                                  final bookIDs = controller.cart
                                      .map((item) => item["bookID"])
                                      .toList();

                                  controller.addToLibrary(bookIDs);
                                  controller.clearCart();
                                },
                              ),
                            )
                          ],
                        )
                      ]),
          ),
        ));
  }
}
