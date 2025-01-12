import 'package:alpha_bookstore/main.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  List cart = [];
  double total = 0;
  bool hasCartFetched = false;
  Future<void> fetchUserCart() async {
    if (!hasCartFetched) {
      final data = await supabase
          .from('cart')
          .select("*, books(title,price,bookImgs)")
          .eq("userID", supabase.auth.currentUser!.id);
      cart = data;
      hasCartFetched = true;
      update();
    }
  }

  Future<void> refreshCart() async {
    final data = await supabase
        .from('cart')
        .select("*, books(title,price,bookImgs)")
        .eq("userID", supabase.auth.currentUser!.id);
    cart = data;
    // update();
  }

  Future<void> calcTotal() async {
    total = 0; // Reset total to 0 before calculation
    for (int i = 0; i < cart.length; i++) {
      total += cart[i]["books"]["price"];
    }
    update(); // Notify listeners of changes
  }

  Future<void> addToCart(int bookID) async {
    await supabase
        .from('cart')
        .insert({'userID': supabase.auth.currentUser!.id, 'bookID': bookID});
    refreshCart();
    Get.back();
    update();
    Get.snackbar("congrats", "Ur book added to the cart");
  }

  Future<void> removeFromCart(int elementID) async {
    await supabase.from('cart').delete().eq("id", elementID);
    refreshCart();
    Get.back();
    update();
    Get.snackbar("congrats", "book removed from cart");
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserCart().then((_) {
      calcTotal(); // Calculate total after fetching the cart
    });
  }
}
