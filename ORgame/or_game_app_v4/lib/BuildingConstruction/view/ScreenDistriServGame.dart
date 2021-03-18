import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:or_game_app_v4/DistributionServices/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/DistributionServices/model/BuildingConstructionModel.dart';
import '../../style.dart';
import 'ScreenDistriServLevel.dart';

class ScreenDistriServGame extends StatefulWidget {
  String difficulty;
  int level;
  DistributionServicesController DSC;
  ScreenDistriServGame(String diff, int lvl) {
    difficulty = diff;
    level = lvl;
    DSC = new DistributionServicesController.fromIndex(difficulty, level);
  }
  createState() => ScreenDistriServGameState(difficulty,level,DSC);
}

class ScreenDistriServGameState extends State<ScreenDistriServGame> {

  String difficulty;
  int level;
  DistributionServicesController DSC;
  bool successfulDrop = false;
  int score = 0;

  ScreenDistriServGameState(this.difficulty,this.level,this.DSC);

  int acceptedData = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children : [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width : MediaQuery.of(context).size.width * 0.70,
                    height: MediaQuery.of(context).size.height,
                    color : Colors.brown,
                    child: Align(
                        child : _buildDragTarget()
                    )
                ),
                Container(
                    width : MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height,
                    color : Colors.pinkAccent,
                    child: StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.all(8),
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 1.0,
                      crossAxisCount: 3,
                      staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(1, DSC.DSM.clients[(DSC.DSM.get_clients_indexes_in_immeuble(0))[index]].nb_etages),
                      itemCount: DSC.DSM.nb_client_in(0),
                      itemBuilder: (BuildContext context, int index) =>
                          Align(
                              child: Client_Draggable(DSC.DSM.clients[(DSC.DSM.get_clients_indexes_in_immeuble(0))[index]])
                          ),
                    )
                ),
              ]
          ),
          Positioned(
              bottom : 0,
              left : 0,
              child : Text('Score $score',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))
          ),
          Positioned(
              top : 0,
              right : 0,
              child : Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      child: Text('Return'),
                      style: Style.returnButtonText,
                      onPressed: () {
                        Navigator.of(context).push( //Navigateur vers widget
                          MaterialPageRoute(builder: (context)=>
                              ScreenDistriServLevel(difficulty),
                          ),
                        );
                      },
                    )
                ),
              )
          ),
        ]
    );
    /*return Container(
      decoration: BoxDecoration(
          color: Colors.teal
      ),
      child: Column (
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    child: Text('Return'),
                    style: Style.returnButtonText,
                    onPressed: () {
                      Navigator.of(context).push( //Navigateur vers widget
                        MaterialPageRoute(builder: (context)=>
                            ScreenDistriServLevel(difficulty),
                        ),
                      );
                    },
                  )
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width : MediaQuery.of(context).size.width * 0.70,
                      height: MediaQuery.of(context).size.height * 0.75,
                      color : Colors.brown,
                      child: Align(
                          child : _buildDragTarget()
                      )
                  ),
                  Container(
                      width : MediaQuery.of(context).size.width * 0.30,
                      height: MediaQuery.of(context).size.height * 0.75,
                      color : Colors.pinkAccent,
                      child: StaggeredGridView.countBuilder(
                        padding: const EdgeInsets.all(8),
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 1.0,
                        crossAxisCount: 3,
                        staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(1, DSC.DSM.clients[(DSC.DSM.get_clients_indexes_in_immeuble(0))[index]].nb_etages),
                        itemCount: DSC.DSM.nb_client_in(0),
                        itemBuilder: (BuildContext context, int index) =>
                            Align(
                                child: Client_Draggable(DSC.DSM.clients[(DSC.DSM.get_clients_indexes_in_immeuble(0))[index]])
                            ),
                      )
                  ),
                ]
            ),
            Text('Score $score',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))
          ]
      ),
    );*/
  }

  Widget _buildDragTarget() {
    return DragTarget<Client>(
      builder: (BuildContext context, List<Client> incoming, List rejected) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            height: 300,
            width: 50,
            child : ListView.builder(
                itemCount: DSC.DSM.get_clients_indexes_in_immeuble(1).length,
                itemBuilder: (BuildContext context, int index) {
                  return Client_Draggable(DSC.DSM.clients[(DSC.DSM.get_clients_indexes_in_immeuble(1))[index]]);
                }
            )
        );
      },
      onWillAccept: (data){
        print("OnWillAccept");
        return true;
      },
      onAccept: (data) {
        print("Accept $data");
        setState(() {
          successfulDrop = true;
          DSC.DSM.assign_client_to_immeuble(data.index,1);
          DSC.DSM.print_clients(0);
        });
      },
      onLeave: (data) {
        print("Not accept");
      },
    );
  }
}

class Client_Draggable extends StatelessWidget {
  Client_Draggable(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Draggable<Client>(
        data: client,
        child: Client_Icon(client),
        feedback : Client_Icon(client),
        childWhenDragging: Container()
    );
  }
}

class Client_Icon extends StatelessWidget {
  Client_Icon(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          alignment: Alignment.center,
          height: 50.0*client.nb_etages,
          width : 50,
          child: Column(
            children: new List.generate(client.nb_etages,
                  (index) => Container(
                  alignment: Alignment.center,
                  height: 50,
                  width : 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )
                  ),
                  child: Text(
                    '${client.gain.toInt()}',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
              ),
            ),
          )
      ),
    );
  }
}
