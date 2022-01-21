import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeandsoundnetworks/NewcallForm.dart';

var selection;


class newCall extends StatefulWidget {
  const newCall({Key? key}) : super(key: key);

  @override
  _newCallState createState() => _newCallState();
}

class _newCallState extends State<newCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('New Call'),
      ),
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.blue)),child:   RaisedButton(onPressed: (){
              setState(() {
                selection = 'Service Call';
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewcallForm()));
            },child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Service Calls'),
            ),color: Colors.white,)),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.blue)),child:   RaisedButton(onPressed: (){
              setState(() {
                selection = 'AMC Call';
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewcallForm()));
            },child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('AMC Calls'),
            ),color: Colors.white,)),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.blue)),child:   RaisedButton(onPressed: (){
              setState(() {
                selection = 'New Installation Call';
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewcallForm()));
            },child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('New Installation Call'),
            ),color: Colors.white,)),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width:MediaQuery.of(context).size.width-50,decoration: BoxDecoration(border: Border.all(color: Colors.blue)),child:   RaisedButton(onPressed: (){
              setState(() {
                selection = 'Demo Call';
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewcallForm()));
            },child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Demo Call'),
            ),color: Colors.white,)),

          ),
        ]),
    ));
  }
}
