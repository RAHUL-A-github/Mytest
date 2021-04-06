import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String useremail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding:
                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      if (username.text == '') {
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
                        useremail = username.text;
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
