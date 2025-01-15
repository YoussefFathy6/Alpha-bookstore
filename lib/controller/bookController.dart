import 'package:alpha_bookstore/main.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Bookcontroller extends GetxController {
  List<Map<String, dynamic>> books = []; // Initialize as an empty list
  bool hasFetchedBooks = false; // Track if books have been fetched

  Future<void> fetchBooks() async {
    print("Inside bookController================================");
    if (!hasFetchedBooks) {
      // Fetch data with authors included
      final data =
          await supabase.from('books').select("*, authors(id, authorName)");

      // Ensure correct data types and handle any missing fields
      books = data.map((book) {
        return {
          "bookImgs": book["bookImgs"] ?? "", // Default to empty string if null
          "title": book["title"] ?? "Untitled",
          "authorName":
              book["authors"]?["authorName"] ?? "Unknown", // Nested author name
          "authorID": book["authors"]?["id"], // Optional: Author ID
          "price": double.tryParse(book["price"].toString()) ?? 0.0,
          "category": book["category"],
          "description": book["description"],
          "discount": book["discount"],
          "id": book["id"],
          "soldCounter": book["soldCounter"],
          "language": book["language"],
          "pagesNum": book["pagesNum"]
        };
      }).toList();

      hasFetchedBooks = true; // Mark as fetched
      update(); // Notify UI to rebuild
    }
  }

  Future<void> refreshBooks() async {
    // Fetch data with authors included
    final data =
        await supabase.from('books').select("*, authors(id, authorName)");

    // Ensure correct data types and handle any missing fields
    books = data.map((book) {
      return {
        "bookImgs": book["bookImgs"] ?? "", // Default to empty string if null
        "title": book["title"] ?? "Untitled",
        "authorName":
            book["authors"]?["authorName"] ?? "Unknown", // Nested author name
        "authorID": book["authors"]?["id"], // Optional: Author ID
        "price": double.tryParse(book["price"].toString()) ?? 0.0,
        "category": book["category"],
        "description": book["description"],
        "discount": book["discount"],
        "id": book["id"],
        "soldCounter": book["soldCounter"],
        "language": book["language"],
        "pagesNum": book["pagesNum"]
      };
    }).toList();

    hasFetchedBooks = true; // Mark as fetched
    update(); // Notify UI to rebuild
  }

  void bookDetailsNavigation(book) {
    Get.toNamed("/bookDetails", arguments: book);
    print(book);
  }

  @override
  void onInit() {
    super.onInit();
    fetchBooks(); // Fetch books on controller initialization
  }
}
