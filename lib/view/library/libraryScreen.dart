import 'package:alpha_bookstore/controller/libraryController.dart';
import 'package:alpha_bookstore/view/library/components/customCard.dart';
import 'package:alpha_bookstore/view/library/components/pdfPageViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Libraryscreen extends StatefulWidget {
  const Libraryscreen({super.key});

  @override
  State<Libraryscreen> createState() => _LibraryscreenState();
}

class _LibraryscreenState extends State<Libraryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: GetBuilder<Librarycontroller>(
          init: Librarycontroller(),
          builder: (controller) => SingleChildScrollView(
                  child: SizedBox(
                width: 500,
                height: 500,
                child: GridView.builder(
                  itemCount: controller.libraryBooks.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 350, crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Customcard(
                        img: controller.libraryBooks[index]["books"]["bookImgs"]
                            [0],
                        title: controller.libraryBooks[index]["books"]["title"],
                        author: controller.libraryBooks[index]["books"]
                            ["authors"]["authorName"],
                        method: () {
                          Get.to(
                              PdfViewerPage(
                                pdfUrl: controller.libraryBooks[index]["books"]
                                    ["pdfUrl"],
                              ),
                              arguments: "title");
                        });
                    // return TextButton(
                    //     onPressed: () {
                    //       print(controller.libraryBooks);
                    //     },
                    //     child: Text("test"));
                  },
                ),
              ))),
    );
  }
}
