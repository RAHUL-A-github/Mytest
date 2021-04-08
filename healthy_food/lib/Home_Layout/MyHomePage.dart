import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/Home_Layout/Notification_Page.dart';
import 'package:healthy_food/Home_Layout/account.dart';
import 'package:healthy_food/Home_Layout/widget/drinks.dart';
import 'package:healthy_food/Home_Layout/widget/fruit.dart';
import 'package:healthy_food/Home_Layout/widget/food.dart';
import 'package:healthy_food/Home_Layout/widget/setting.dart';
import 'package:healthy_food/Home_Layout/widget/vagitables.dart';
import 'package:healthy_food/Login/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  //used in shared_preferences
  String userEmail;
  DocumentReference userRef;

  // used in firebase current user
  String useremail, username, userimage, uid;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _getUserEmail();
    tabController = TabController(length: 4, vsync: this);
  }

  _getUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    useremail = user.email;
    uid = user.uid;
    SharedPreferences pref = await SharedPreferences.getInstance();
    userEmail = pref.getString('userEmail');
    setState(() {});
  }

  _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext ctx) => Login()));
    pref.clear();
    print('Log out Successfully......');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      key: scaffoldKey,
      drawer: new Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 185.0,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('uid', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("hey there is some error");
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final List<DocumentSnapshot> documents =
                          snapshot.data.docs;
                      return ListView(
                          children: documents
                              .map(
                                (doc) =>
                                UserAccountsDrawerHeader(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(60.0),
                                      bottomRight: Radius.circular(60.0),
                                    ),
                                  ),
                                  accountName: Text(
                                    '${doc['name']},${doc['lname']}',
                                    style: TextStyle(fontFamily: 'OpenSans'),
                                  ),
                                  accountEmail: Text(
                                    doc['email'],
                                    style: TextStyle(fontFamily: 'OpenSans'),
                                  ),
                                  currentAccountPicture: CircleAvatar(
                                    backgroundImage: NetworkImage(doc['image']),
                                  ),
                                ),
                          )
                              .toList());
                    }
                  },
                ),
              ),
              Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text(
                          'Account',
                          style: TextStyle(fontFamily: 'OpenSans'),
                        ),
                        leading: Icon(Icons.account_circle),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserAccountPage()));

                        },
                      ),
                      ListTile(
                        title: Text(
                          'Notification',
                          style: TextStyle(fontFamily: 'OpenSans'),
                        ),
                        leading: Icon(Icons.notifications),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notificationspage()));
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Setting',
                          style: TextStyle(fontFamily: 'OpenSans'),
                        ),
                        leading: Icon(Icons.settings),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingPage()));
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () => scaffoldKey.currentState.openDrawer(),
                ),
                Text(
                  '   Grocery',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35.0,
                      fontFamily: 'OpenSans'),
                ),
                TextButton.icon(
                    onPressed: () async {
                      await _logOut();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    //hoverColor: Colors.black,

                    label: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    )),

              ],
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TabBar(
                    controller: tabController,
                    indicatorColor: Colors.white,
                    indicatorWeight: 3.0,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "Drinks",
                          style: TextStyle(
                              fontSize: 2.5 * 7, fontFamily: 'OpenSans'),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Vegetables",
                          style: TextStyle(
                              fontSize: 2.5 * 7, fontFamily: 'OpenSans'),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Food",
                          style: TextStyle(
                              fontSize: 2.5 * 7, fontFamily: 'OpenSans'),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Fruits",
                          style: TextStyle(
                              fontSize: 2.5 * 7, fontFamily: 'OpenSans'),
                        ),
                      ),
                    ]),
                // SizedBox(width: 10.0),
                // Text(
                //   'Food',
                //   style: TextStyle(color: Colors.white, fontSize: 25.0),
                // ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(top: 70.0),
            height: MediaQuery
                .of(context)
                .size
                .height - 182.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 300.0,
              child: TabBarView(controller: tabController, children: <Widget>[
                Drinks(),
                Vagitable(),
                Food(),
                Fruit(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}