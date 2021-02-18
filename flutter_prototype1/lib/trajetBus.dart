import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/style.dart';


class MenuTrajetBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu du voyageur de commerce",
        theme: Style.themeTrajetBus,
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
                          print('Play pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TrajetBus())
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

class TrajetBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: "Jeu du voyageur de commerce",
        theme: Style.themeTrajetBus,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Jeu du voyageur de commerce"),
            ),
            body: Center(
                child :  Stack(
                    children : [
                      Positioned(left: 300, top: 150, child: Text("Inserer Jeu 2")),
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