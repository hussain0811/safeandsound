import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safeandsoundnetworks/OpenCalls.dart';
import 'package:safeandsoundnetworks/newCall.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'CloseCalls.dart';
import 'ProgressCalls.dart';


final _fireStore = FirebaseFirestore.instance;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CALL MANAGEMENT FOR SAFE AND SOUND NETWORKS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
  void initState()  {

  super.initState();
  _saveDeviceToken();
  onesignaltest();

  }

void _saveDeviceToken() async {
  await Firebase.initializeApp().whenComplete(() {
  print("completed");
  setState(() {});});

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width:MediaQuery.of(context).size.width-50,child: RaisedButton(onPressed: (){
                  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => newCall()));
              },child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Log a new Call'),
              ),color: Colors.blue,)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.green)),child:   RaisedButton(onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Opencalls()));
              },child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Open Call'),
              ),color: Colors.white,)),

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.orange)),child:   RaisedButton(onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Progresscalls()));
              },child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('In Progress Calls'),
              ),color: Colors.white,)),

            ),   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.red)),child:   RaisedButton(onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Closecalls()));
              },child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Close Calls'),
              ),color: Colors.white,)),

            ),
          ],
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
void onesignaltest()  {
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("e54433c2-a09e-4009-98ad-5ab317b018de");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });



}