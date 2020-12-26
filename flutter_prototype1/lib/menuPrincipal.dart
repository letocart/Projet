import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_prototype1/style.dart';
import 'package:flutter_prototype1/distributionService.dart';
import 'package:flutter_prototype1/trajetBus.dart';

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
      theme: Style.themePrincipal,
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
                        print("Jeu n°1 pressed");
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuDistributionService())
                        );
                      },
                      style : Style.buttonText,
                      child: Text('Jeu n°1')
                  ),
                  TextButton(
                      onPressed: (){
                        print('Jeu 2 pressed');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuTrajetBus())
                        );
                      },
                      style : Style.buttonText,
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

