import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class modular extends StatefulWidget {
  String choice = "";

  modular(String choice) {
    this.choice = choice;
    print(this.choice);
  }

  @override
  _modularState createState() => _modularState(this.choice);

}

class _modularState extends State<modular> {
  List data;
  String choice = "";

  _modularState(String choice) {
    this.choice = choice;
    print("choice = "+this.choice);
  }

  Future<String> loadJsonData(String choice) async {
    var jsonText = await rootBundle.loadString('assets/person'+choice+'.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData(this.choice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:new ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {

                    var name = data[index]['name'];
                    var email = data[index]['email'];

                    return new Column(
                      children: <Widget>[
                        new ListTile(
                          leading: CircleAvatar(
                            child: new Icon(Icons.account_box),
                          ),
                          title: Text(name),
                          subtitle: Text(email),
                        ),
                        new Divider(),
                      ],
                    );
                  }), // This trailing comma makes auto-formatting nicer for build methods.
            );
  }

}