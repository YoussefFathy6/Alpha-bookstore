import 'package:alpha_bookstore/controller/authController.dart';
import 'package:alpha_bookstore/main.dart';
import 'package:alpha_bookstore/view/auth/components/customSubmitBtn.dart';
import 'package:alpha_bookstore/view/auth/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/numericVals.dart';
import '../../constants/links.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  @override
  var formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(paddingPage),
        child: Center(
          child: ListView(
            children: [
              Image.asset(darkLogo),
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 300,
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Customtextfield(
                          hintText: "Username",
                          isSecured: false,
                          inputvalue: username,
                        ),
                        Customtextfield(
                          hintText: "email",
                          isSecured: false,
                          inputvalue: email,
                        ),
                        Customtextfield(
                          hintText: "Password",
                          isSecured: true,
                          inputvalue: password,
                        ),
                        Customtextfield(
                          hintText: "Confirm Password",
                          isSecured: true,
                          inputvalue: confirmPass,
                        ),
                      ],
                    )),
              ),
              GetBuilder<Authcontroller>(
                  init: Authcontroller(),
                  builder: (controller) => Customsubmitbtn(
                      label: "Signup",
                      method: () async {
                        await controller.register(
                            username.text, email.text, password.text);
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                      onPressed: () {
                        Get.offNamed("/login");
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffEF5A5A)),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
