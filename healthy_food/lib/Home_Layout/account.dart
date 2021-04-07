import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_food/model/usermodel.dart';
class UserAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),

      ),
      body:UserPrefrences(),
    );
  }
}
class UserPrefrences extends StatefulWidget {
 
  @override
  _UserPrefrencesState createState() => _UserPrefrencesState();
}
class _UserPrefrencesState extends State<UserPrefrences> {
  String _firebaseAuth = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

 TextEditingController nameController = TextEditingController();
  //DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: new StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('users')
      //         .where('uid', isEqualTo: _firebaseAuth)
      //         .snapshots(),
      //     builder: (context, snapshot){
      //       if (!snapshot.hasData){
      //         return SingleChildScrollView(
      //             child: Center(
      //                 child: CircularProgressIndicator()),
      //         );
      //       }
      //       else if (snapshot.hasError) {
      //         return Text('Error occurred..');
      //
      //         }
      //       else{
      //         final List<DocumentSnapshot> documents = snapshot.data.docs;
      //         return ListView(
      //             children: documents
      //                 .map((doc) => Container(
      //               padding: EdgeInsets.only(top: 20.0),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       Container(
      //                         height: 150.0,
      //                         width: 150.0,
      //                         decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                             image: DecorationImage(
      //                             image: NetworkImage(doc['image']),
      //                             fit: BoxFit.cover,
      //                           ),
      //                         ),),
      //                       Text('First Name: ${doc['name']}'),
      //                       Text('Last Name: ${doc['lname']}'),
      //                       Text('E-mail: ${doc['email']}'),
      //                     ],
      //                   ),
      //                 ))
      //                 .toList());
      //       }
      //     }
      //
      // ),
      body: Container(
        child: FutureBuilder(
          future:  users.doc(_firebaseAuth).get(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text('something wents wrong');
            }
            if(snapshot.connectionState == ConnectionState.done){
              Map<String, dynamic> data = snapshot.data.data();
              UserData userData=UserData.fromJson(data);
              //print("userData:${userData.image}");
              return Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 35.0),
                      Center(
                        child: GestureDetector(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Color(0xffFDCF09),
                            child: userData.image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.network(
                                userData.image,
                                width: 140,
                                height: 140,
                                fit: BoxFit.fill,
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(100)),
                              width: 150,
                              height: 150,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(

                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0,),
                            Text("Name: ${userData.name} ${userData.lname}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0,),
                            Text("E-mail: ${userData.email}",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0,),
                            Text("mob:${userData.mobileNumber}",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text('');
          },
        ),
      ),
    );
  }
}

