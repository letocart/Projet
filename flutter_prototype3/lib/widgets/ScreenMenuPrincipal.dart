import 'package:flutter/material.dart';
import '../style.dart';

class ScreenMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/city2.jpg"),
              fit: BoxFit.cover)),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : [
          Image.asset('assets/images/professeur.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              RaisedButton(
                  onPressed: () {
                    print("jeu 1 pressed");
                  },
                  color : Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text('Game 1',style: TextStyle(color:Colors.black),)
              ),
              RaisedButton(
                  onPressed: () {
                    print("Jeu 2 pressed");
                  },
                  color : Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text('Game 2',style: TextStyle(color:Colors.black),)
              ),
            ],
          ),
        ],
      ),
    );
  }
}