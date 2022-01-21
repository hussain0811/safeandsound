// ignore: file_names
// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _fireStore = FirebaseFirestore.instance;


class Closecalls extends StatefulWidget {
  const Closecalls({Key? key}) : super(key: key);

  @override
  _ClosecallsState createState() => _ClosecallsState();
}

class _ClosecallsState extends State<Closecalls> {
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
        title: Text('Close Calls'),
      ),
      body:  ListView(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream:
              _fireStore.collection('Calls').where('call',isEqualTo: 'Close').snapshots(),
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
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(onPressed: (){
                                      _fireStore.collection('Calls').doc(document.id).update(
                                          {'call': 'Open'});
                                    },child: Text('Open'),color: Colors.green,),
                                    RaisedButton(onPressed: (){
                                      _fireStore.collection('Calls').doc(document.id).update(
                                          {'call': 'Progress'});
                                    },child: Text('Progress'),color: Colors.orange,),

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
    );
  }
}


