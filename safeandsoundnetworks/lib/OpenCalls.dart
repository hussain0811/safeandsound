// ignore: file_names
// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

final _fireStore = FirebaseFirestore.instance;


class Opencalls extends StatefulWidget {
  const Opencalls({Key? key}) : super(key: key);

  @override
  _OpencallsState createState() => _OpencallsState();
}

class _OpencallsState extends State<Opencalls> {
  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});});
    super.initState();

  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Open Calls'),
      ),
      body:  Container(
        child: ListView(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream:
                _fireStore.collection('Calls').where('call',isEqualTo: 'Open').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Container(width:50,child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasData) {
                    return Container(
                      child: Column(
    children:
    snapshot.data!.docs.map((DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    return Card(
        child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type - ${data['type']}'),
            Text('Product - ${data['product']}'),
            Text('Company Name - ${data['companyname']}'),
            Text('Description - ${data['description']}'),
            Text('Charges - ${data['charges']}'),
            Text('Name - ${data['coustname']}'),
            Text('Whatsapp - ${data['coustno']}'),
            Text('Log Time - ${data['logtime']}'),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                RaisedButton(onPressed: (){
                  _fireStore.collection('Calls').doc(document.id).update(
                      {'call': 'Progress'});
                },child: Text('Progress'),color: Colors.orange,),
                RaisedButton(onPressed: (){
                  _fireStore.collection('Calls').doc(document.id).update(
                      {'call': 'Close'});
                  final link = WhatsAppUnilink(
                    phoneNumber: '+91${data['coustno']}',
                    text: "",
                  );
                },child: Text('Close'),color: Colors.red,),
              ],
            )
          ],
        ),
          trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
            _fireStore.collection('Calls').doc(document.id).delete();
          },),
        ),
    );
    }).toList(),
                      ),
                    );
                  } else {
                    return Text('No Data');
                  }
                }),
          ],
        ),
      ),
    );
  }
}


