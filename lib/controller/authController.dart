import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<void> loginWithGoogle() async {
    const webClientId =
        '263181333110-itia466sib1j87120ghnm6su1f2q0juf.apps.googleusercontent.com';

    const iosClientId =
        '263181333110-itia466sib1j87120ghnm6su1f2q0juf.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed("/login");
  }
}
