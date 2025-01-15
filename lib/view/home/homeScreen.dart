// ignore_for_file: file_names

import 'package:alpha_bookstore/constants/numericVals.dart';
import 'package:alpha_bookstore/controller/authController.dart';
import 'package:alpha_bookstore/controller/bookController.dart';
import 'package:alpha_bookstore/controller/cartController.dart';
import 'package:alpha_bookstore/controller/userController.dart';
import 'package:alpha_bookstore/main.dart';
import 'package:alpha_bookstore/view/cart/components/customDrawerBtn.dart';
import 'package:alpha_bookstore/view/home/components/screenContent.dart';
import 'package:alpha_bookstore/view/library/libraryScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int index = 0;
  GlobalKey<FormState> myKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> myWidgets = [
    const Screencontent(),
    const Text("profileScreen"),
    const Libraryscreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.grey[700],
            )),
        actions: [
          GetBuilder<Cartcontroller>(
            init: Cartcontroller(),
            builder: (controller) => IconButton(
                onPressed: () {
                  print(controller.cart);
                },
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.grey[700],
                )),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 40,
                height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: GetBuilder<Usercontroller>(
                    init: Usercontroller(),
                    builder: (controller) => controller.user != null
                        ? Image.network(
                            controller.user[0]["profilePic"],
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                )),
          )
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: paddingPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<Usercontroller>(
                  builder: (controller) => Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        decoration: const BoxDecoration(
                            border: BorderDirectional(
                                bottom: BorderSide(width: .5))),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              width: 60,
                              height: 60,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.user[0]["username"]),
                                Text(controller.user[0]["email"]),
                              ],
                            )
                          ],
                        ),
                      )),
              Customdrawerbtn(
                  icon: Icons.shopping_cart_outlined,
                  title: "Cart",
                  method: () {
                    _scaffoldKey.currentState!.closeDrawer();
                    Get.toNamed("/cart");
                    // print("done");
                  }),
              Customdrawerbtn(
                  icon: Icons.settings, title: "Settings", method: () {}),
              GetBuilder<Authcontroller>(
                init: Authcontroller(),
                builder: (controller) => Customdrawerbtn(
                    icon: Icons.exit_to_app_rounded,
                    title: "Logout",
                    method: () {
                      controller.logout();
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) => setState(() {
                index = value;
              }),
          selectedItemColor: const Color(0xffEF5A5A),
          selectedIconTheme: const IconThemeData(size: 30),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shelves), label: "Books"),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_rounded), label: "Library"),
          ]),
      body: Container(
          padding: EdgeInsets.all(paddingPage),
          child: myWidgets.elementAt(index)),
    );
  }
}
