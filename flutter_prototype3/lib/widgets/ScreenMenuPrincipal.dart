import 'package:flutter/material.dart';
import '../style.dart';

class ScreenMenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : [
          Image.asset('assets/images/professeur.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              TextButton(
                  onPressed: () {
                    print("Jeu n°1 pressed");
                  },
                  style : Style.buttonText,
                  child: Text('Jeu n°1')
              ),
              TextButton(
                  onPressed: (){
                    print('Jeu 2 pressed');
                  },
                  style : Style.buttonText,
                  child: Text('Jeu n°2')
              ),
            ],
          ),
        ],
      ),
    );
  }
}