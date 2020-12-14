import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/style.dart';

class MenuDistributionService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu d'ordonnancement à n machine",
        theme: Style.themeDistributionService,
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
                          print('Play pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DistributionService())
                          );
                        },
                        style : Style.buttonText,
                        child: Text('Jouer')
                    ),
                    TextButton(
                        onPressed: (){
                          print('Return pressed');
                          Navigator.pop(context);
                        },
                        style : Style.buttonText,
                        child: Text('Retour')
                    ),
                  ],
                )
            )
        )
    );
  }
}


class DistributionService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu d'ordonnancement à n machine",
        theme: Style.themeDistributionService,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu d'ordonnancement à n machine"),
            ),
            body: Center(
                child :  Stack(
                    children : [
                      Positioned(left: 300, top: 150, child: Text("Inserer Jeu 1")),
                      Positioned(
                          right: 0,
                          child:
                          TextButton(
                              onPressed: ()
                              {
                                print('Return pressed');
                                Navigator.pop(context);
                              },
                              style : Style.buttonText,
                              child: Text('Retour')
                          )
                      )
                    ]
                )
            )
        )
    );
  }
}