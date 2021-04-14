import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_food/model/usermodel.dart';

class UserAccountPage extends StatefulWidget {
  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.1),
        elevation: 5.0,
        centerTitle: true,
        title: Text('Profile Page',style: TextStyle(color: Colors.yellowAccent,fontSize: 20.0,fontWeight: FontWeight.bold),),

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
  bool access = false;
 TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  FocusNode name;
  FocusNode email;
  FocusNode num;
@override
  void initState() {
    // TODO: implement initState
  name = FocusNode();
  email = FocusNode();
  num = FocusNode();
  super.initState();
  }
  @override
  void dispose() {

    // TODO: implement dispose
    name.dispose();
    email.dispose();
    num.dispose();
    super.dispose();
  }

  //DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                emailController.text = '${userData.email}';
                nameController.text = '${userData.name} ${userData.lname}';
                numController.text = '${userData.mobileNumber}';
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
                              SizedBox(height: 15.0,),
                              TextFormField(

                                autofocus:true,
                                focusNode: name,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (val) {
                                  name.unfocus();
                                  FocusScope.of(context).requestFocus(num);
                                },
                                enabled: access,
                                style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),
                                obscureText: false,
                                controller: nameController,
                                decoration: InputDecoration(
                                  // fillColor: Colors.yellowAccent.withOpacity(0.8),
                                  // filled: true,
                                  prefixIcon: Icon(Icons.person,color: Colors.black,),
                                  contentPadding:
                                  EdgeInsets.all(12.0),
                                ),

                              ),

                              TextFormField(
                                enabled: access,
                                onFieldSubmitted: (val) {
                                  num.unfocus();
                                },
                                focusNode: num,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),
                                obscureText: false,
                                controller: numController,
                                decoration: InputDecoration(
                                  // fillColor: Colors.yellowAccent.withOpacity(0.8),
                                  // filled: true,
                                  prefixIcon: Icon(Icons.phone,color: Colors.black,),
                                  contentPadding:
                                  EdgeInsets.all(12.0),
                                ),

                              ),
                              // SizedBox(height: 10.0,),
                              // Text("Name: ${userData.name} ${userData.lname}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.yellowAccent),),
                              // SizedBox(height: 10.0,),
                              // Text("E-mail: ${userData.email}",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.yellowAccent)),
                              // SizedBox(height: 10.0,),
                              // Text("Contact No: ${userData.mobileNumber}",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.yellowAccent)),
                              SizedBox(height: 20.0,),
                              Text("E-Mail : ${userData.email}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black)),
                              SizedBox(height: 10.0,),
                              Text("Registered on: ${userData.date}",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.black)),

                            ],

                          ),
                        ),
                        SizedBox(height:40.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black.withOpacity(0.5),
                              child: MaterialButton(
                                padding:
                                EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
                                onPressed: () {
                                  setState(() {
                                    access = true;
                                  });

                                },
                                child: Text(
                                  'Edit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black.withOpacity(0.5),
                              child: MaterialButton(
                                padding:
                                EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
                                onPressed: () {
                                  setState(() {
                                    access = false;
                                  });

                                },
                                child: Text(
                                  'Save',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
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
      ),
    );
  }

  // TakeAccess() {
  //   setState(() {
  //     access = false;
  //   });
  // }
}

