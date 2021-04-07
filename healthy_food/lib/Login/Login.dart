import 'package:flutter/material.dart';
import 'Login_Form.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login_Page(),
    );
  }
}

// ignore: camel_case_types
class Login_Page extends StatefulWidget {
  @override
  _Login_PageState createState() => _Login_PageState();
}

// ignore: camel_case_types
class _Login_PageState extends State<Login_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LoginForm(),
    );
  }
}
