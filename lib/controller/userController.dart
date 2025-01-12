import 'package:alpha_bookstore/main.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Usercontroller extends GetxController {
  var user;
  Future<PostgrestList> fetchUser() async {
    final data = await supabase
        .from('users')
        .select()
        .eq("userID", supabase.auth.currentUser!.id);
    update();
    return data;
  }

  @override
  void onInit() async {
    user = await fetchUser();
    super.onInit();
  }
}
