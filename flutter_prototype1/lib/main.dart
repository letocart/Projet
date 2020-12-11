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
                      print("Jeu n°1 pressed");
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuJeu1())
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
                          MaterialPageRoute(builder: (context) => MenuJeu2())
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

class MenuJeu1 extends StatelessWidget {
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
                        print('Play pressed');
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
                      child: Text('Jouer')
                  ),
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

class MenuJeu2 extends StatelessWidget {
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
                          print('Play pressed');
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FenetreJeu2())
                          );
                        },
                        style : TextButton.styleFrom
                          (
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          onSurface: Colors.grey,
                        ),
                        child: Text('Jouer')
                    ),
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
                                  style : TextButton.styleFrom
                                    (
                                    primary: Colors.white,
                                    backgroundColor: Colors.teal,
                                    onSurface: Colors.grey,
                                  ),
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

class FenetreJeu2 extends StatelessWidget {
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
              child :  Stack(
                  children : [
                    Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          child: Draggable(
                            child : Container(
                              width: 400,
                              height: 400,
                              child: CustomPaint(
                                painter: OpenPainter(),
                              ),
                            ),
                            feedback : Container(
                              width: 400,
                              height: 400,
                              child: CustomPaint(
                                painter: OpenPainter(),
                              ),
                            ),
                              childWhenDragging: Container()
                          )
                        )
                    ),
                    Positioned(
                        right: 0,
                        child:
                        TextButton(
                            onPressed: ()
                            {
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
                        )
                    )
                  ]
              )
          )
        )
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xffAC33FF)
      ..style = PaintingStyle.fill;
    //a rectangle
    canvas.drawRect(Offset(100, 100) & Size(200, 100), paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}