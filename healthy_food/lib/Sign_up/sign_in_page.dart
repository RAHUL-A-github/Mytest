import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:healthy_food/Home_Layout/MyHomePage.dart';
import 'package:healthy_food/Home_Layout/widget/loading.dart';
import 'package:healthy_food/Login/Login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// ignore: camel_case_types
class Sign_in_page extends StatefulWidget {
  @override
  _Sign_in_pageState createState() => _Sign_in_pageState();
}

void _setUserEmail(String useremail) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('userEmail', useremail);
}

// ignore: camel_case_types
class _Sign_in_pageState extends State<Sign_in_page> {

  String _name, _lname, _email, _userImage, _uId, _mobile;
  File _image;
  final picker = ImagePicker();
  bool isHidden = true;
  bool isLoading = false;
  bool active = false;
  Uint8List profileImage;
  var profileImageUrl;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController numController = TextEditingController();
  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode lnameFocus = FocusNode();
  FocusNode mobFocus = FocusNode();
  // ignore: non_constant_identifier_names
  FocusNode re_passwordFocus = FocusNode();

  // ignore: non_constant_identifier_names
  TextEditingController confirm_password = TextEditingController();

  // ignore: non_constant_identifier_names
  final _sign_formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  build(BuildContext context) {
    return Form(
      key: _sign_formkey,
      child: active ? SignUpLoading() : Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 35.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: InkWell(
                          child: Icon(Icons.cancel,
                              color: Colors.grey, size: 35.0),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(50.0, 0.0, 0.0, 0.0),
                        child: SizedBox(
                          child: Text(
                            'Create Profile',
                            style: (TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 35.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        openGallery(context);
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Color(0xffFDCF09),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.file(
                                  _image,
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
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: TextFormField(
                      focusNode: nameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(lnameFocus);
                      },
                      validator: (value) => value.length < 1 ? 'Require' : null,
                      controller: name,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          // suffixIcon: InkWell(
                          //     child: Icon(Icons.clear_all),
                          //     onTap: () {
                          //       name.text = '';
                          //     }),
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: TextFormField(
                      focusNode: lnameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                      validator: (value) => value.length < 1 ? 'Require' : null,
                      controller: lname,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          // suffixIcon: InkWell(
                          //     child: Icon(Icons.clear_all),
                          //     onTap: () {
                          //       lname.text = '';
                          //     }),
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: TextFormField(
                      focusNode: emailFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      validator: (value) =>
                          !EmailValidator.validate(value, true)
                              ? 'Not a valid email.'
                              : null,
                      controller: email,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          // suffixIcon: InkWell(
                          //     child: Icon(Icons.clear_all),
                          //     onTap: () {
                          //       email.text = '';
                          //     }),
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      focusNode: passwordFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(re_passwordFocus);
                      },
                      validator: (value) =>
                          value.length <= 1 ? 'Require' : null,
                      controller: password,
                      obscureText: isHidden,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              child: Icon(Icons.visibility),
                              onTap: password_view),
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      focusNode: re_passwordFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (val) {
                        nameFocus.unfocus();
                      },
                      validator: (value) =>
                          value.length <= 1 ? 'Require' : null,
                      obscureText: true,
                      style: TextStyle(fontSize: 18.0),
                      controller: confirm_password,
                      decoration: InputDecoration(
                        // suffixIcon: InkWell(
                        //     child: Icon(Icons.clear_all),
                        //     onTap: () {
                        //       email.text = '';
                        //     }),
                        contentPadding:
                            EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        labelText: 'Re-password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      focusNode: mobFocus,
                      onFieldSubmitted: (val) {
                        re_passwordFocus.unfocus();
                      },
                      validator: (value) => value.length <= 9
                          ? 'please enter the 10 digit no'
                          : null,
                      obscureText: false,
                      style: TextStyle(fontSize: 18.0),
                      controller: numController,
                      decoration: InputDecoration(
                        // suffixIcon: InkWell(
                        //     child: Icon(Icons.clear_all),
                        //     onTap: () {
                        //       numController.text = '';
                        //     }),
                        contentPadding:
                            EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                        labelText: 'Mobile No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blueAccent,
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(115.0, 10.0, 120.0, 10.0),
                      onPressed: () async {
                        if(password.text != confirm_password.text )
                          {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Confirm Password not Match....!'),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        else{
                          if(_image != null )
                            {
                              await _handleSignIn();
                              final User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              ))
                                  .user;
                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Home_Page()));
                                String email = _email;
                                print(user.uid);
                                print(user.email);
                                print('Sign Up Successfully......');
                                _setUserEmail(email);
                              }
                            }
                          else{
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Please Select The Image....!'),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                      child: Text(
                        'Sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  // ignore: non_constant_identifier_names
  void password_view() {
    setState(() {
      if (isHidden == true) {
        isHidden = false;
      } else {
        isHidden = true;
      }
    });
  }

  //stored user data on firestore
  Future<void> addData() async {
    _name = name.text;
    _lname = lname.text;
    _email = email.text;
    _uId = _auth.currentUser.uid;
    _mobile = numController.text;
    _userImage = profileImageUrl.toString();
    print(_userImage);
    try {
      if (_sign_formkey.currentState.validate()) {
        if (password.text == confirm_password.text) {
          var firebaseUser = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser.uid)
              .set({
            "uid": '$_uId',
            "name": '$_name',
            "lname": '$_lname',
            "email": '$_email',
            "image": '$_userImage',
            "Mobile": '$_mobile',
          });
        } else {
          setState(() => active = false);
          final snackBar = SnackBar(
            content: Text('Password Not Matched..!'),
            action: SnackBarAction(
              label: 'Warning',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }

    catch (e) {
      if(mounted)
        return setState(() => active = false);
      print(e);
    }
  }

  // create user with email and password
  Future<void> register() async {
    if (_sign_formkey.currentState.validate()) {
      setState(() => active = true);
      try{
        final User user = (await _auth.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        )).user;
      }on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      }
      catch(e){
        print(e);
        setState(()=>active = false);

      }

      }
    else {
      if(mounted)
        return setState(() => active = false);
      print('user not registered');
    }
  }

  //get image

  Future<void> openGallery(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.gallery);

    this.setState(() {
      if (picture != null) {
        _image = File(picture.path);
        print('Image Path $_image');
      } else {
        print('No image selected');
      }
    });

    //Navigator.of(context).pop();
  }

  Future<String> putImage(BuildContext context) async {
    var user = FirebaseAuth.instance.currentUser;
    profileImage = await _image.readAsBytes();
    var storageRef = FirebaseStorage.instance.ref();
    var task = storageRef.child(user.uid).putData(profileImage);

    task.snapshotEvents.listen((event) {});

    return (await task.whenComplete(() {})).ref.getDownloadURL();
  }

  _handleSignIn() async {
    await register();
    if(active == true)
      {
        profileImageUrl = await putImage(context);
        await addData();
      }



  }
}
