import 'package:flutter/material.dart';

class Notificationspage extends StatefulWidget {
  @override
  _NotificationspageState createState() => _NotificationspageState();
}

class _NotificationspageState extends State<Notificationspage> {
  List notifications =
  List<String>.generate(0, (index) => 'notification $index');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.yellowAccent,),
        ),
        title: Text(
          'Notification List',
          style: TextStyle(fontSize: 20,color: Colors.yellowAccent),
        ),
      ),

      body: Container(

        child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.notifications),
                title: Text(
                  notifications[index],
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                trailing: Icon(
                  Icons.delete,
                  color: Colors.red,

                ),

              );
            }),
      ),
    );
  }
}
