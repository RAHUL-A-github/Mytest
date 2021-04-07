import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/Home_Layout/MyHomePage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:healthy_food/Home_Layout/widget/forgetpassword.dart';
import 'package:healthy_food/Home_Layout/widget/loading.dart';
import 'package:healthy_food/Sign_up/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}
void _setUserEmail(String useremail) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userEmail', useremail);
}
// ignore: camel_case_types
class _LoginFormState extends State<LoginForm> {
  bool active = false;
  //FlutterOtp otp = FlutterOtp();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode userFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool isHidden = true;
  final _formkey = GlobalKey<FormState>();

  // void loginCommand() {
  //   Navigator.of(context)
  //       .pushReplacement(MaterialPageRoute(builder: (context) => Home_Page()));
  // }
  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    userFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: active
          ? SignInLoading()
          : Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        Text(
                          'The Grocery Bag',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          'change the way',
                          style: TextStyle(fontSize: 22.0, color: Colors.red),
                        ),
                        Container(
                          child: SizedBox(
                            height: 275.0,
                            child: Image.asset(
                              'assets/images/splash_screen.png',
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          focusNode: userFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            userFocus.unfocus();
                            FocusScope.of(context).requestFocus(passwordFocus);
                          },
                          validator: (value) =>
                              !EmailValidator.validate(value, true)
                                  ? 'Not a valid email.'
                                  : null,
                          onSaved: (value) => username.text = value,
                          style: TextStyle(fontSize: 18.0),
                          obscureText: false,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: 'username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          controller: username,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          onFieldSubmitted: (val) {
                            passwordFocus.unfocus();
                          },
                          focusNode: passwordFocus,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: 18.0),
                          obscureText: isHidden,
                          controller: password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.security),
                            suffixIcon: InkWell(
                              child: Icon(Icons.visibility),
                              onTap: password_view,
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: 'password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){

                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => ForgetPassword()));
                              },
                              child: SizedBox(
                                height: 30,child: Text('Forget Password'),
                              ),
                            ),
                          ],
                        ),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.blueAccent,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {}
                              if (username.text == '' || password.text == '') {
                                final snackBar = SnackBar(
                                  content: Text(
                                      'Please Enter username & Password..!'),
                                  action: SnackBarAction(
                                    label: 'warning',
                                    onPressed: () {},
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                setState(() => active = true);
                                await _handleSignIn();
                                // setState(() => active = false);
                              }
                            },
                            child: Text(
                              'Log In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'or',
                          style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.blueAccent,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text(
                              'Sign up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // ignore: non_constant_identifier_names
  void password_view() {
    setState(() {
      if (isHidden == true) {
        isHidden = false;
      } else {
        isHidden = true;
      }
    });
  }

  _handleSignIn() async {
    try {
      final User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text,
      ))
          .user;
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
        String email = username.text;
        print(user.uid);
        print(user.email);
        print('Log In Successfully......');
        _setUserEmail(email);
      }
    } catch (e) {
      setState(() => active = false);
      switch (e.code) {
        case "wrong-password":
          {
            final snackBar = SnackBar(
              content: Text('password was Incorrect..!'),
              action: SnackBarAction(
                label: 'warning',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        case "user-not-found":
          {
            final snackBar = SnackBar(
              content: Text('E-mail was Incorrect..!'),
              action: SnackBarAction(
                label: 'warning',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
      }
    }
  }
}
