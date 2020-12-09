import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'Notre application',
        home: Menu(),
        )
  );
}

class Menu extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Jouons à la RO',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white70,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jouons à la RO'),
        ),
        body: Center(
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children : [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [Text('Je suis un personnage')]
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                TextButton(
                    onPressed: () {
                      print("Jeu n°2 pressed");
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Jeu1())
                      );
                    },
                    style : TextButton.styleFrom
                      (
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: Text('Jeu n°1')
                ),
                TextButton(
                    onPressed: (){
                      print('Jeu 2 pressed');
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Jeu2())
                      );
                    },
                    style : TextButton.styleFrom
                      (
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: Text('Jeu n°2')
                ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Jeu1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu d'ordonnancement à n machine",
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Jeu d'ordonnancement à n machine"),
            ),
          body: Center(
            child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                Text("Jeu n°1"),
                TextButton(
                    onPressed: (){
                      print('Return pressed');
                      Navigator.pop(context);
                    },
                    style : TextButton.styleFrom
                      (
                      primary: Colors.white,
                      backgroundColor: Colors.teal,
                      onSurface: Colors.grey,
                    ),
                    child: Text('Retour')
                  ),
                ],
              )
            )
        )
    );
  }
}

class Jeu2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu du voyageur de commerce",
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.amberAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu du voyageur de commerce"),
            ),
            body: Center(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Text("Jeu n°2"),
                    TextButton(
                        onPressed: (){
                          print('Return pressed');
                          Navigator.pop(context);
                        },
                        style : TextButton.styleFrom
                          (
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          onSurface: Colors.grey,
                        ),
                        child: Text('Retour')
                    ),
                  ],
                )
            )
        )
    );
  }
}
