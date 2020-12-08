import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Jouons à la RO',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jouons à la RO'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              Container(
                child: Text('Je suis un personnage')
              ),
              Container(
                child: Column(
                  children:<Widget>[
                    TextButton(
                      child: Text('Jeu n°1'),
                      onPressed: (){
                        print('Jeu 1 pressed');
                      }
                    ),
                    TextButton(
                        child: Text('Jeu n°2'),
                        onPressed: (){
                          print('Jeu 2 pressed');
                        }
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
