import 'package:alpha_bookstore/constants/links.dart';
import 'package:alpha_bookstore/middleware/authMiddleware.dart';
import 'package:alpha_bookstore/view/auth/loginScreen.dart';
import 'package:alpha_bookstore/view/auth/signupScreen.dart';
import 'package:alpha_bookstore/view/bookDetails/bookDetailsScreen.dart';
import 'package:alpha_bookstore/view/cart/cartScreen.dart';
import 'package:alpha_bookstore/view/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/numericVals.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://mibtkwexoiyduvtpmpyx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1pYnRrd2V4b2l5ZHV2dHBtcHl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ3OTc2NjMsImV4cCI6MjA1MDM3MzY2M30.GFdLq6aoLubvQzGXYwQqGF1BKwRQjrcGmVo_rqqAgFY',
  );
  runApp(const MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/signup", page: () => Signupscreen()),
        GetPage(
            name: "/login",
            page: () => Loginscreen(),
            middlewares: [Authmiddleware()]),
        GetPage(name: "/", page: () => Homescreen()),
        GetPage(name: "/bookDetails", page: () => Bookdetailsscreen()),
        GetPage(name: "/cart", page: () => Cartscreen()),
      ],
    );
  }
}
