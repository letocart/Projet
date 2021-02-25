import 'package:flutter/material.dart';
import 'package:flutter_prototype1/widgets/ScreenMenuPrincipal.dart';
import '../style.dart';
import 'package:flutter/services.dart';


// widget ecran titre
class ScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( // Container principal
      decoration: BoxDecoration(  // background
        image: DecorationImage(
          image: AssetImage("assets/images/backgrounds/city2.jpg"), // image du background
          fit: BoxFit.cover //couvre tout l'ecran
        )
      ),
      alignment: Alignment.center, // s'alligne au centre
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children : [
          SizedBox( //Sized Box d'ecart
            height : 50,
          ),
          Text('Welcome to RO Game',style : TextStyle(
            fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height : 20,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push( //Navigateur vers widget
                MaterialPageRoute(builder: (context)=>
                    ScreenMenuPrincipal(),
                ),
              );
              print("Start Game pressed");
              },
              color : Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text('Start Game',style: TextStyle(color:Colors.white),)
          ),
          RaisedButton(
              onPressed: () {
                SystemNavigator.pop();
                print("Exit pressed");
              },
              color : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Text('Exit',style: TextStyle(color:Colors.black),)
          ),
  ],
    ),
    );
  }
}
