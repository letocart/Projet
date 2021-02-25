import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenDistriServStage extends StatelessWidget {
  final List<String> entries = <String>['Tutoriel', 'Easy', 'Normal', 'Hard', 'Insane'];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backgrounds/city2.jpg"),
                fit: BoxFit.cover)
        ),
        alignment: Alignment.center,
        child: Column(
            children: [
              SizedBox( //Sized Box d'ecart
                height : 50,
              ),
              Text('Choose a difficulty',style : TextStyle(
                  fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RaisedButton(
                      onPressed: () {
                        /*Navigator.of(context).push( //Navigateur vers widget
                          MaterialPageRoute(builder: (context)=>
                              ScreenMenuPrincipal(),
                          ),
                        );*/
                        print("Start Game ${entries[index]} pressed");
                      },
                      color : Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text('${entries[index]}',style: TextStyle(color:Colors.white),)
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
              )
          ])
    );
  }
}