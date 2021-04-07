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
        title: Text('Setting'),
      ),
      body: buildSettingsList(),
    );
  }

  buildSettingsList() {
    return Container(
      child: FutureBuilder(
          future: users.doc(_firebaseAuth).get(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if(snapshot.connectionState == ConnectionState.done){
              Map<String, dynamic> data = snapshot.data.data();
              UserData userData = UserData.fromJson(data);
            return Container(
              child: SettingsList(
                contentPadding: EdgeInsets.only(top: 10.0),
                sections: [
                  SettingsSection(
                    title: 'Account',
                    tiles: [
                      SettingsTile(
                        title: userData.name,
                        leading: Icon(Icons.person)
                        , onTap: () {


                      },),
                      SettingsTile(
                        title: userData.mobileNumber,
                        leading: Icon(Icons.phone),
                        onTap: (){

                        },
                      ),
                      SettingsTile(
                          title: userData.email,
                          leading: Icon(Icons.email),
                          onTap: () {


                          }),
                    ],
                  ),
                  SettingsSection(
                    title: 'Security',
                    tiles: [
                      SettingsTile.switchTile(
                        title: 'Enable Notifications',
                        enabled: notificationsEnabled,
                        leading: Icon(Icons.notifications_active),
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
                            setState(() async {
                              SharedPreferences pref = await SharedPreferences
                                  .getInstance();
                              pref.clear();
                              print('Account Deleted Successfully........');
                              active = true;
                            });

                            deleteuser();
                          },
                          title: 'Delete Account',
                          leading: Icon(Icons.delete_forever)),
                    ],
                  ),
                  SettingsSection(
                    title: 'Misc',
                    tiles: [
                      SettingsTile(
                          title: 'Terms of Service',
                          leading: Icon(Icons.description),
                          onTap: () {


                          }),
                      SettingsTile(
                          title: 'Open source licenses',
                          leading: Icon(Icons.collections_bookmark),
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
  void deleteuser() {
    userCollection.doc(FirebaseAuth.instance.currentUser.uid).delete();
    FirebaseAuth.instance.currentUser.delete();
  }
}
