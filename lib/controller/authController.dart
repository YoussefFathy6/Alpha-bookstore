import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class Authcontroller extends GetxController {
  Future<void> register(String username, String email, String password) async {
    try {
      // Attempt to sign up the user
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final Session? session = res.session;
      final User? user = res.user;
      print("====================================$user");
      print("====================================$session");
      if (user != null) {
        // Registration successful, navigate to home
        // await Future.delayed(Duration(milliseconds: 200));
        await supabase.from('users').insert({
          'username': username,
          'email': email,
          'userID': user.id,
          'profilePic':
              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg"
        });
        Get.offNamed('/');
      } else {
        // Handle unexpected null values
        print('Sign-up succeeded but user or session is null');
      }
    } catch (e) {
      // Handle errors
      print('Error during sign-up: $e');
      // Show user-friendly error message if necessary
      Get.snackbar('Sign-up Failed', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      // Attempt to sign up the user
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
      print("====================================$user");
      print("====================================$session");
      if (user != null) {
        // Registration successful, navigate to home
        // await Future.delayed(Duration(milliseconds: 200));

        Get.offNamed('/');
      } else {
        // Handle unexpected null values
        print('Sign-up succeeded but user or session is null');
      }
    } catch (e) {
      // Handle errors
      print('Error during sign-up: $e');
      // Show user-friendly error message if necessary
      Get.snackbar('Sign-up Failed', e.toString());
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed("/login");
  }
}
