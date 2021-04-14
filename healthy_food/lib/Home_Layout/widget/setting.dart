import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:healthy_food/model/usermodel.dart';
import 'dialogbox.dart';
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _firebaseAuth = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool active = false;
  bool notificationsEnabled = true;
  String deleteMail;
  bool svalue = false;

  @override
  Widget build(BuildContext context) {
    return active ? AccountDelete(deleteMail):Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Setting',style: TextStyle(color: Colors.yellowAccent),),
        backgroundColor: Colors.black.withOpacity(0.2),
      ),
      body: buildSettingsList(),
    );
  }

  buildSettingsList() {
    return Container(
      color: Colors.white.withOpacity(0.1),
      child: FutureBuilder(
          future: users.doc(_firebaseAuth).get(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
            if(snapshot.connectionState == ConnectionState.done){
              Map<String, dynamic> data = snapshot.data.data();
              UserData userData = UserData.fromJson(data);
            return Container(
              child: SettingsList(
                backgroundColor: Colors.black.withOpacity(0.1),
                contentPadding: EdgeInsets.only(top: 10.0),
                sections: [
                  SettingsSection(
                    title: 'Account',titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    tiles: [
                      SettingsTile(
                        title: '${userData.name} ${userData.lname}',titleTextStyle: TextStyle(color: Colors.black),
                        leading: Icon(Icons.person,color: Colors.black,)
                        , onTap: () {


                      },),
                      SettingsTile(
                        title: '+91 ${userData.mobileNumber}',titleTextStyle: TextStyle(color: Colors.black),
                        leading: Icon(Icons.phone,color: Colors.black,),
                        onTap: (){

                        },
                      ),
                      SettingsTile(
                          title: userData.email,titleTextStyle: TextStyle(color: Colors.black),
                          leading: Icon(Icons.email,color: Colors.black,),
                          onTap: () {


                          }),
                    ],
                  ),
                  SettingsSection(
                    title: 'Security',titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    tiles: [
                      SettingsTile.switchTile(
                        title: 'Enable Notifications',titleTextStyle: TextStyle(color: Colors.black),
                        enabled: notificationsEnabled,
                        leading: Icon(Icons.notifications_active,color: Colors.black,),
                        switchValue: svalue,
                        onToggle: (value) {
                          setState(() {
                            if (svalue == true) {
                              svalue = false;
                            } else {
                              svalue = true;
                            }
                          });
                        },
                      ),
                      SettingsTile(
                          onTap: () {
                            deleteMail =
                                FirebaseAuth.instance.currentUser.email;
                            setState((){
                              print('Account Deleted Successfully........');
                              active = true;
                            });

                            deleteuser();
                          },
                          title: 'Delete Account',titleTextStyle: TextStyle(color: Colors.black),
                          leading: Icon(Icons.delete_forever,color: Colors.black,)),
                    ],
                  ),
                  SettingsSection(
                    title: 'Misc',titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    tiles: [
                      SettingsTile(
                          title: 'Terms of Service',titleTextStyle: TextStyle(color: Colors.black),
                          leading: Icon(Icons.description,color: Colors.black,),
                          onTap: () {


                          }),
                      SettingsTile(
                          title: 'Open source licenses',titleTextStyle: TextStyle(color: Colors.black),
                          leading: Icon(Icons.collections_bookmark,color: Colors.black,),
                          onTap: () {


                          }),
                    ],
                  ),
                  CustomSection(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 180, bottom: 5),
                          child: Image.asset(
                            'assets/images/settings.png',
                            height: 40,
                            width: 40,
                            color: Color(0xFF777777),
                          ),
                        ),
                        Text(
                          'Version: 1',style: TextStyle(color: Color(0xFF777777)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
            return Text('');
          }
      ),
    );
  }
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');
  Future<void> deleteuser() async {
    userCollection.doc(FirebaseAuth.instance.currentUser.uid).delete();
    FirebaseAuth.instance.currentUser.delete();
    SharedPreferences pref = await SharedPreferences
        .getInstance();
    pref.clear();
  }
}
