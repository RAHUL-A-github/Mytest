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
  bool errorflag = false;
  TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String useremail;
  @override
  Widget build(BuildContext context) {
    return active
        ? EmailSent(useremail)
        : Scaffold(
      backgroundColor: Colors.white.withOpacity(0.6),
            appBar: AppBar(
              backgroundColor: Colors.yellowAccent.withOpacity(0.5),
              title: Text('Forget Password',style: TextStyle(color: Colors.yellowAccent),),

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
                     // color: Colors.blue,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      border: Border.all(color: Colors.black,width: 4),
                        color: Colors.black.withOpacity(0.1)
                      ),


                      //decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      alignment: Alignment.center,
                      //color: Colors.yellowAccent.withOpacity(0.4),
                      height: 300,
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) =>
                                  !EmailValidator.validate(value, true)
                                      ? 'Not a valid email.'
                                      : null,
                              onSaved: (value) => username.text = value,
                              style: TextStyle(fontSize: 18.0,color: Colors.yellowAccent),
                              obscureText: false,
                              decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.5),
                                filled: true,
                                prefixIcon: Icon(Icons.email_outlined,color: Colors.black,),
                                contentPadding:
                                    EdgeInsets.all(15.0),
                                //hintText: 'E-mail',
                                labelText: 'Enter E-mail',labelStyle: TextStyle(color: Colors.black,fontSize: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              controller: username,
                            ),
                            SizedBox(height: 50.0,),
                            Container(
                              height: 50,
                              width: 120,
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.yellowAccent.withOpacity(0.4),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {}
                                    if (username.text == '') {
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.yellowAccent.withOpacity(0.4),
                                        content: Text('Please Enter the E-mail..!',style: TextStyle(color: Colors.yellowAccent),),
                                        action: SnackBarAction(
                                          label: '',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      useremail = username.text;
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      auth.sendPasswordResetEmail(email: useremail)
                                          .then((value) =>
                                          setState(() {
                                            active = true;}))
                                          .catchError((error) => usernotfoundpopup(),

                                      );
                                    }
                                  },
                                  child: Text(
                                    'Send Link',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.yellowAccent,
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

                  ],
                ),
              ),
            ),
          );
  }
  void usernotfoundpopup(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellowAccent,
          title: Text('Error',style: TextStyle(color: Colors.black),),
          content: Text("User Not Found",style: TextStyle(fontSize: 18.0,color: Colors.black),),
        );
      },
    );
  }
}
