import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:or_game_app_v4/BuildingConstruction/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:or_game_app_v4/BuildingConstruction/model/BuildingConstructionModel.dart';
import 'package:or_game_app_v4/BuildingConstruction/view/ScreenBuildingConstructionLevel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';

import '../../style.dart';

class ScreenBuildingConstructionGame extends StatefulWidget {
  String difficulty;
  int level;
  BuildingConstructionController BCC;
  /*ScreenBuildingConstructionGame(String diff, int lvl) {
    difficulty = diff;
    level = lvl;
  }*/
  ScreenBuildingConstructionGame(this.difficulty, this.level, this.BCC);
  //createState() => BuildingConstructionGameState(difficulty,level);
  createState() => BuildingConstructionGameState(this.difficulty, this.level, this.BCC);
}

class BuildingConstructionGameState extends State<ScreenBuildingConstructionGame> {

  List data;
  String difficulty;
  int level;
  //bool isInitialized = false;
  BuildingConstructionController BCC;
  int score = 0;

  //BuildingConstructionGameState(this.difficulty,this.level);
  BuildingConstructionGameState(this.difficulty, this.level, this.BCC);
/*
  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/problemInstances/BuildingConstruction/'
        'BuildingConstruction_'+difficulty+'_'+level.toString()+'.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }
*/
  int acceptedData = 0;
  @override
  Widget build(BuildContext context) {
    /*if(!isInitialized) {
      isInitialized = true;
      double solutionValue = data==null ? 0 : data[0]['solutionValue'];
      int numberOfBuildings = data==null ? 0 : data[0]['numberOfBuildings'];
      int maxHeight = data==null ? 0 : data[0]['maxHeight'];
      List<double> pricesOfFloors = [];
      List<double> earningsFromClients = [];
      List<int> requestsOfFloorsFromClients = [];
      if(data!=null) {
        for(int i=0;i<data[0]['pricesOfFloors'].length;i++)
          pricesOfFloors.add(data[0]['pricesOfFloors'][i].toDouble());

        for(int i=0;i<data[0]['earningsFromClients'].length;i++)
          earningsFromClients.add(data[0]['earningsFromClients'][i].toDouble());

        for(int i=0;i<data[0]['requestsOfFloorsFromClients'].length;i++)
          requestsOfFloorsFromClients.add(data[0]['requestsOfFloorsFromClients'][i]);
      }
      BCC=BuildingConstructionController.fromBCD(
          BuildingConstructionData(solutionValue,
              numberOfBuildings,maxHeight,pricesOfFloors,
              earningsFromClients,requestsOfFloorsFromClients));

    }*/
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
                    padding: EdgeInsets.only(top: 50),
                    color : Colors.white70,
                    child : DragTarget<Client>(
                      builder: (BuildContext context, List<Client> incoming, List rejected) {
                        return StaggeredGridView.countBuilder(
                          crossAxisCount: 3,
                          staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(1, BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]].getRequestOfFloors),
                          itemCount: BCC.getNumberOfClientsInBuilding(0),
                          itemBuilder: (BuildContext context, int index) =>
                              Client_Draggable(BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]]),
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
          ),
          IconWidget(Axis.vertical),
          Positioned(
              top : 0,
              left : MediaQuery.of(context).size.width * 0.65 - 24,
              child : Material(
                color : Colors.transparent,
                child: Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder()),
                    child : IconButton(
                      padding: EdgeInsets.only(top : 10),
                      constraints: BoxConstraints(),
                      icon: Image.asset('assets/images/icon/ampoule.png'),
                      onPressed: () {
                        print("Ampoule pressed");
                      },
                    )
                ),
              )
          ),
          Positioned(
              bottom : 0,
              left : MediaQuery.of(context).size.width * 0.65 - 48,
              child : Material(
                color : Colors.transparent,
                child: Ink(
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color : Colors.blueGrey
                    ),
                    child : IconButton(
                      constraints: BoxConstraints(),
                      icon: Image.asset('assets/images/icon/check.png'),
                      onPressed: () {
                        print("Check pressed");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                content: new Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    (BCC.getBCM.solutionPercentage()==100) ? Image.asset('assets/images/YouWin.png') : Text("You lose"),
                                    Text("Winning percentage : ${BCC.getBCM.solutionPercentage()} %"),
                                  ],
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: const Text('Keep trying'),
                                  ),
                                  new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push( //Navigateur vers widget
                                        MaterialPageRoute(builder: (context)=>
                                            ScreenBuildingConstructionLevel(difficulty),
                                        ),
                                      );
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: const Text('return'),
                                  ),
                                ],
                              ),
                        );
                      },
                    )
                ),
              )
          )
        ]
    );
  }

  Widget _buildDragTarget(int index_building) {
    return DragTarget<Client>(
      builder: (BuildContext context, List<Client> incoming, List rejected) {
        return Container(
            height: 15 *
                BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
            width: 50,
            child:
            Stack(
                children : [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount : BCC.getBCM.getDescriptionOfBuildings.getMaxHeight,
                      itemBuilder : (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            height: 15,
                            width: 50
                        );
                      }
                  ),
                  ListView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: BCC
                          .getClientsIndexesInBuilding(index_building)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return Client_Draggable(
                            BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(
                                index_building))[index]]);
                      }
                  )
                ]
            )
        );
      },
      onWillAccept: (data) {
        print("OnWillAccept");
        return true;
      },
      onAccept: (data) {
        print("Accept $data");
        setState(() {
          BCC.getBCM.assignClientToBuilding(data.getIndex, index_building);
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
    return Align(
        alignment: Alignment.topCenter,
        child : Material(
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
                          color: colorRatio(), //Color.fromARGB(255, ((client.getEarning~/client.getRequestOfFloors)>255) ? 0 : (255-(client.getEarning~/client.getRequestOfFloors)) , (client.getEarning~/client.getRequestOfFloors>255) ? 255 : (0+(client.getEarning~/client.getRequestOfFloors)), 0),
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
        )
    );
  }


  Color colorRatio()
  {
    var ratio = client.getEarning~/client.getRequestOfFloors;
    int green;
    int red;

    if(ratio<=255) {
      red = 255;
      green = ratio;
    }
    else if(ratio<=510) {
      red = 510 - ratio;
      green = 255;
    }
    else {
      green = 255;
      red = 0;
    }

    return Color.fromARGB(255, red, green, 0);
  }

}
