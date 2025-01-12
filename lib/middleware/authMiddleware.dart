import 'package:alpha_bookstore/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authmiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (supabase.auth.currentUser != null) {
      return RouteSettings(name: "/");
    }
  }
}
