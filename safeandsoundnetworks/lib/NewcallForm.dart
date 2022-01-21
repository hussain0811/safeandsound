import 'dart:convert';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:http/http.dart';
import 'newCall.dart';
final _fireStore = FirebaseFirestore.instance;
final descController = TextEditingController();
final chargesController = TextEditingController();
final noController = TextEditingController();
final nameController = TextEditingController();
final companyController = TextEditingController();
var dropdown = 'CCTV' ;

class NewcallForm extends StatefulWidget {
  const NewcallForm({Key? key}) : super(key: key);

  @override
  _NewcallFormState createState() => _NewcallFormState();
}

class _NewcallFormState extends State<NewcallForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Service Call'),
        ),
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            value: dropdown,
            onChanged: (newValue) {
              setState(() {
                dropdown = newValue!;
              });
            },
            items: <String>[
              'CCTV',
              'ACS',
              'FAS',
              'PA',
              'Time& Attendance',
              'Walkie Talkie'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          Row(
            children: [
              Text('Descpription. -'),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  controller: descController,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Call Charges -'),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  keyboardType:TextInputType.number ,
                  controller: chargesController,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Company Name -'),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  controller: companyController
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Customer Name -'),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  controller: nameController,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Customer Whtsp. -'),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 150,
                child: TextFormField(
                  keyboardType:TextInputType.number,
                  controller: noController,
                ),
              )
            ],
          ),
          RaisedButton(onPressed: () async {

            _fireStore.collection('Calls').add({
              'call': 'Open',
              'charges': chargesController.text,
              'companyname' : companyController.text,
              'coustname': nameController.text,
              'coustno' : noController.text,
              'description': descController.text,
              'product': '${dropdown}',
              'type':'${selection}',
              'logtime':'${DateTime.now()}'.substring(0,19)
            });
            final link = WhatsAppUnilink(
              phoneNumber: '+91${noController.text}',
              text: "*Safe and Sound Networks* has logged *${selection}* for *${dropdown}*  for *${descController.text}* . Our engineer would visit shortly. Visit charges amount  *Rs${chargesController.text}*. Any material would be charged extra as applicable. Please confirm to proceed.",
            );
            await launch('$link');
setState(() {
  chargesController.clear();
  companyController.clear();
  nameController.clear();
  noController.clear();
  descController.clear();
  dropdown = 'CCTV';
});
            var userId = OneSignal.shared.getDeviceState().then((value) => {
              _saveDeviceToken(value?.userId)
            });

           final snap = await _fireStore
                .collection('pushtokens').get();
            final allData =   snap.docs.map((doc) => doc.data()).toList();
           print('aaaaaaaaaaaaaaaaaaaa${allData}');
// ignore: deprecated_member_use
            List<String> tokenids = [];
for (int i =0;i<allData.length;i++){
  tokenids.add(allData[i]['devtokens']);
            }
            sendNotification(tokenids,'Test','Testing');


          },child: Text('Submit'),)
        ]))
    );
  }
}

Future<Response> sendNotification(List<String> tokenIdList, String contents, String heading) async{

  return await post(
    Uri.parse('https://onesignal.com/api/v1/notifications'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>
    {
      "app_id": 'e54433c2-a09e-4009-98ad-5ab317b018de',//kAppId is the App Id that one get from the OneSignal When the application is registered.

      "include_player_ids": tokenIdList,//tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

      // android_accent_color reprsent the color of the heading text in the notifiction
      "android_accent_color":"FF9976D2",

      "headings": {"en": heading},

      "contents": {"en": contents},


    }),
  );
}


bool fcmToken = true;
void _saveDeviceToken(String? token) async {
  final snapshot = await _fireStore
      .collection('pushtokens')
      .where('devtokens', isEqualTo: token)
      .get();
  if (snapshot.docs.isNotEmpty) {

    fcmToken = false;

  }

  if (token != null) {
    if (fcmToken) {
      _fireStore.collection('pushtokens').add({
        'devtokens': token,
      });
    }
  }
}