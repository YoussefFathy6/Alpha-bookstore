import 'package:alpha_bookstore/controller/authController.dart';
import 'package:alpha_bookstore/view/auth/components/customSubmitBtn.dart';
import 'package:alpha_bookstore/view/auth/components/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/numericVals.dart';
import '../../constants/links.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Loginscreen> {
  @override
  var formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                padding: EdgeInsets.only(top: 20),
                height: 180,
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                      ],
                    )),
              ),
              GetBuilder<Authcontroller>(
                init: Authcontroller(),
                builder: (controller) => Customsubmitbtn(
                    label: "Login",
                    method: () {
                      controller.login(email.text, password.text);
                    }),
              ),
              Text(
                "OR",
                textAlign: TextAlign.center,
              ),
              GetBuilder<Authcontroller>(
                  builder: (contorller) => OutlinedButton(
                      onPressed: () {
                        contorller.loginWithGoogle();
                      },
                      child: Text("data"))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don`t have account? "),
                  TextButton(
                      onPressed: () {
                        Get.offNamed("/signup");
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffEF5A5A)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
