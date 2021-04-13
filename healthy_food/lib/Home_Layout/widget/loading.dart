import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignInLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please Wait..',style: TextStyle(color: Colors.yellowAccent,fontSize: 25.0),),
            SizedBox(height: 10.0,),
            SpinKitCircle(
              color: Colors.yellowAccent,
              size: 50.0,
            ),
            Text('Sign in...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
          ],
        ),
      ),
    );
  }
}

class SignUpLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Please Wait..',style: TextStyle(color: Colors.yellowAccent,fontSize: 25.0),),
            SizedBox(height: 10.0,),
            SpinKitCircle(
              color: Colors.yellowAccent,
              size: 50.0,
            ),
            Text('Sign Up...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
          ],
        ),
      ),
    );
  }
}