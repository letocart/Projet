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
                  width : MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height,
                  //color : Colors.brown,
                  child: ListView(
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      children : [
                        Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/backgrounds/bgDistributionService.png"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                )
                            ),
                            height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
                            alignment: Alignment.center,
                            child: Row(
                                children : [
                                  Container(
                                      height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
                                      width : MediaQuery.of(context).size.width * 0.15,
                                      child : ListView.builder(
                                          reverse: true,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: BCC.getBCM.getDescriptionOfBuildings.getMaxHeight,
                                          itemBuilder: (BuildContext context, int index){
                                            return Container(
                                                height: 15,
                                                width: 50,
                                                alignment: Alignment.centerRight,
                                                child: Text('${BCC.getBCM.getDescriptionOfBuildings.getPricesOfFloors[index].toInt()}', style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration.none)
                                                )
                                            );
                                          }
                                      )
                                  ),
                                  Container(
                                      height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
                                      width : MediaQuery.of(context).size.width * 0.5,
                                      child : ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: BCC.getBCM.getDescriptionOfBuildings.getNumberOfBuildings,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: _buildDragTarget(index+1),
                                          );
                                        },
                                      )
                                  ),
                                ]
                            )
                        )]
                  ),
                ),
                Container(
                    width : MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height,
                    color : Colors.white70,
                    child : DragTarget<Client>(
                      builder: (BuildContext context, List<Client> incoming, List rejected) {
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(1, BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]].getRequestOfFloors),
                          itemCount: BCC.getNumberOfClientsInBuilding(0),
                          itemBuilder: (BuildContext context, int index) =>
                              Align(
                                  child: Client_Draggable(BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]])
                              ),
                        );
                      },
                      onWillAccept: (data){
                        print("OnWillAccept");
                        return true;
                      },
                      onAccept: (data) {
                        print("Accept $data");
                        setState(() {
                          BCC.getBCM.assignClientToBuilding(data.getIndex,0);
                          BCC.getBCM.updateScore();
                        });
                      },
                      onLeave: (data) {
                        print("Not accept");
                      },
                    ))]),
          Positioned(
              bottom : 0,
              right : 0,
              child : Container (
                  width : MediaQuery.of(context).size.width * 0.35,
                  color: Colors.blueGrey,
                  alignment : Alignment.center,
                  child : Text('Score ${BCC.getBCM.getScore.toInt()}',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))
              )
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
                  )
              )
          )]
    );
  }

  Widget _buildDragTarget(int index_building) {
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
            height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
            width: 50,
            child : ListView.builder(
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: BCC.getClientsIndexesInBuilding(index_building).length,
                itemBuilder: (BuildContext context, int index) {
                  return Client_Draggable(BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(index_building))[index]]);
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
          BCC.getBCM.assignClientToBuilding(data.getIndex,index_building);
          BCC.getBCM.updateScore();
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
          height: 15.0*client.getRequestOfFloors,
          width : 50,
          /*decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
          ),
          child: Text(
            '${client.getEarning.toInt()}',
            style: TextStyle(color: Colors.black, fontSize: 10)
          ),*/
          child: Column(
            children: new List.generate(client.getRequestOfFloors,
                  (index) => Container(
                  alignment: Alignment.center,
                  height: 15,
                  width : 50,
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )
                  ),
                  child: Text(
                    '${index==0?client.getEarning.toInt():''}',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
              ),
            ),
          )
      ),
    );
  }
}
