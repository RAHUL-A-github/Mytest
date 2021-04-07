import 'package:flutter/material.dart';
import 'package:healthy_food/Sign_up/sign_in_page.dart';
// ignore: camel_case_types
class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SignInPage(),
    );
  }
}
