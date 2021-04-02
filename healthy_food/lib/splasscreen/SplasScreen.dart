import 'package:flutter/material.dart';
import 'package:healthy_food/Home_Layout/MyHomePage.dart';
import 'package:healthy_food/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  String userEmail;
  @override
  void initState() {
    super.initState();
    startAnimation();
    _getUserEmail();
  }

  _getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    userEmail = pref.getString('userEmail');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: animation.value,
              duration: Duration(milliseconds: 1000),
              child: Text('Grocery Bag',style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold,fontSize: 45.0),),
            ),
            AnimatedOpacity(
              opacity: animation.value,
              duration: Duration(milliseconds: 1000),
              child: Text('change the way',style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.bold,fontSize: 25.0),),
            ),
         Container(
           height: 300,
           width: 300,
           child:AnimatedOpacity(
             opacity: animation.value,
             duration: Duration(milliseconds: 1000),
             child: Image.asset(
               'assets/images/splash_screen.png',
               fit: BoxFit.fitWidth,
               height: 400,
               width: 200,
             ),

           ),
         ),

        ],
        ),
      ),
    );
  }
  void startAnimation() {
    animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    animation.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        if (userEmail != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home_Page()));
        } else {
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => Login()));
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
        }
      }
    });
  }
}
