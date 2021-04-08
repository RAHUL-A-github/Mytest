import 'package:flutter/material.dart';
import 'package:healthy_food/Login/Login.dart';
// ignore: must_be_immutable
class EmailSent extends StatelessWidget {

  String email;
  EmailSent(this.email);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Successful"),
      content: Text("Password Reset mail sent on $email",style: TextStyle(fontSize: 18.0),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("okay"),
        ),
      ],
    );
  }
}

class AccountDelete extends StatelessWidget {

  String deleteMail;

  AccountDelete(String deleteMail) : deleteMail = deleteMail;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Deleted"),
      content: Text("Account $deleteMail was Successfully Deleted",style: TextStyle(fontSize: 18.0),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        Login()));
          },
          child: Text("okay"),
        ),
      ],
    );
  }
}

