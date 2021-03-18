
import 'package:flutter/cupertino.dart';
import 'package:or_game_app_v4/BuildingConstruction/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/BuildingConstruction/model/BuildingConstructionModel.dart';
import 'package:or_game_app_v4/BuildingConstruction/view/ScreenBuildingConstructionLevel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../style.dart';

class ScreenBuildingConstructionGame extends StatefulWidget {
  String difficulty;
  int level;
  BuildingConstructionController BCC;
  ScreenBuildingConstructionGame(String diff, int lvl) {
    difficulty = diff;
    level = lvl;
    BCC = new BuildingConstructionController.fromIndex(difficulty, level);
  }
  createState() => BuildingConstructionGameState(difficulty,level,BCC);
}

class BuildingConstructionGameState extends State<ScreenBuildingConstructionGame> {

  String difficulty;
  int level;
  BuildingConstructionController BCC;
  bool successfulDrop = false;
  int score = 0;

  BuildingConstructionGameState(this.difficulty,this.level,this.BCC);

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
                      new StaggeredTile.count(1, BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]].getRequestOfFloors),
                      itemCount: BCC.getNumberOfClientsInBuilding(0),
                      itemBuilder: (BuildContext context, int index) =>
                          Align(
                              child: Client_Draggable(BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]])
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
                              ScreenBuildingConstructionLevel(difficulty),
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
                itemCount: BCC.getClientsIndexesInBuilding(1).length,
                itemBuilder: (BuildContext context, int index) {
                  return Client_Draggable(BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(1))[index]]);
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
          BCC.getBCM.assignClientToBuilding(data.getIndex,1);
          //BCC.getBCM.print_clients(0);
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
          height: 50.0*client.getRequestOfFloors,
          width : 50,
          child: Column(
            children: new List.generate(client.getRequestOfFloors,
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
                    '${client.getEarning.toInt()}',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
              ),
            ),
          )
      ),
    );
  }
}
