import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dialogbox.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool active = false;
  TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String useremail;
  @override
  Widget build(BuildContext context) {
    return active
        ? EmailSent(useremail)
        : Scaffold(
            appBar: AppBar(
              title: Text('Forget Password'),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            !EmailValidator.validate(value, true)
                                ? 'Not a valid email.'
                                : null,
                        onSaved: (value) => username.text = value,
                        style: TextStyle(fontSize: 18.0),
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          //hintText: 'E-mail',
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        controller: username,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 120,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blueAccent,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {}
                            if (username.text == '') {
                              final snackBar = SnackBar(
                                content: Text('Please Enter the E-mail..!'),
                                action: SnackBarAction(
                                  label: 'warning',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              // try {
                              //   useremail = username.text;
                              //   FirebaseAuth auth = FirebaseAuth.instance;
                              //   auth.sendPasswordResetEmail(email: useremail);
                              //   // setState(() {
                              //   //   active = true;
                              //   // });
                              // } catch (e) {
                              //   print(e);
                              //   //setState(() => active = false);
                              //   switch (e.code) {
                              //     case "user-not-found":
                              //       {
                              //         final snackBar = SnackBar(
                              //           content: Text('user not found..!'),
                              //           action: SnackBarAction(
                              //             label: 'warning',
                              //             onPressed: () {},
                              //           ),
                              //         );
                              //         ScaffoldMessenger.of(context)
                              //             .showSnackBar(snackBar);
                              //       }
                              //       break;
                              //   }
                              // }

                              setState(() {
                                active = true;
                              });

                              useremail = username.text;
                              FirebaseAuth auth = FirebaseAuth.instance;

                              auth.sendPasswordResetEmail(email: useremail);

                              //FirebaseFirestore.instance.sendPasswordResetEmail(email: useremail);
                            }
                          },
                          child: Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
