import 'package:alpha_bookstore/controller/cartController.dart';
import 'package:alpha_bookstore/main.dart';
import 'package:get/get.dart';

class Librarycontroller extends GetxController {
  List libraryBooks = [];
  double get total => Get.find<Cartcontroller>().total;
  List get cart => Get.find<Cartcontroller>().cart;
  bool hasLibraryFetched = false;
  Future<void> fetchUserLibrary() async {
    print("Inside libraryController================================");

    if (!hasLibraryFetched) {
      final data = await supabase.from('library').select("""
      *,
      books (
        title,
        bookImgs,
        pdfUrl,
        authors (
          authorName
        )
      )
    """).eq("userID", supabase.auth.currentUser!.id);

      libraryBooks = data;
      hasLibraryFetched = true;
      update();
    }
  }

  Future<void> refreshLibrary() async {
    final data = await supabase.from('library').select("""
      *,
      books (
        title,
        bookImgs,
        pdfUrl,
        authors (
          authorName
        )
      )
    """).eq("userID", supabase.auth.currentUser!.id);

    libraryBooks = data;
    // update();
  }

  // Future<void> salesCounterIncreament(List<Map<String, dynamic>> books) async {
  //   books.forEach((book) async => await supabase
  //       .from('books')
  //       .update({'name': 'Australia'}).eq('id', 1));
  // }

  Future<void> addToLibrary(List<dynamic> bookIDs) async {
    // Prepare a list of maps for batch insertion
    final booksToInsert = bookIDs.map((bookID) {
      return {'userID': supabase.auth.currentUser!.id, 'bookID': bookID};
    }).toList();

    // Insert the list into the 'library' table
    final response = await supabase.from('library').insert(booksToInsert);

    if (response.error == null) {
      refreshLibrary();
      update();
      Get.snackbar("Success", "Books added to your library successfully");
    } else {
      Get.snackbar("Error", "Failed to add books: ${response.error!.message}");
    }
  }

  Future<void> clearCart() async {
    await supabase
        .from('cart')
        .delete()
        .eq('userID', supabase.auth.currentUser!.id);
    // cart.clear(); // Clear the local cart list
    // total = 0;    // Reset the total to 0
    update(); // Notify listeners
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserLibrary();
  }
}
