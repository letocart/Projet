import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view/ScreenHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

// creation de la classe widget ROgameUI est un StatefulWidget (widget pouvant changer d'etat)
class ORgameUI extends StatefulWidget {
  final ORgameUIState state = ORgameUIState();
  State<StatefulWidget> createState() => state;
}

class ORgameUIState extends State<ORgameUI> with WidgetsBindingObserver {

  //SharedPreferences _storage; //creation d'un storage
  /*
  List BuildingConstructionInstances;
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/problemInstances/BuildingConstructionInstances.json');
    setState(() => BuildingConstructionInstances = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }
  */

  /* initialisation et recuperation de donnees stockees
  int score = 0;
  int highScore = 0;

*/
  /*SharedPreferences get storage => _storage;

  set storage(SharedPreferences value) {
    _storage = value;
    //highScore = storage.getInt('high-score') ?? 0;
    if (mounted) {
      update();
    }
  }



  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void update() {
    setState(() {});
  }*/
/*
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("jsontest"),
      ),
      body: new ListView.builder(
          itemCount: BuildingConstructionInstances == null ? 0 : BuildingConstructionInstances.length,
          itemBuilder: (BuildContext context, int index) {

            var difficulty = BuildingConstructionInstances[index]['difficulty'];
            var level = BuildingConstructionInstances[index]['level'];

            return new Column(
              children: <Widget>[
                new ListTile(
                  leading: CircleAvatar(
                    child: new Icon(Icons.account_box),
                  ),
                  title: Text(difficulty),
                  subtitle: Text(level.toString()),
                ),
                new Divider(),
              ],
            );
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }*/

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return ScreenHome();
  }
}
