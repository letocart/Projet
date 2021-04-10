// inspiration code for PopUp when first arrived:
// https://stackoverflow.com/questions/62536438/how-to-show-a-popup-on-app-start-in-flutter

// imports
import 'package:flutter/cupertino.dart';
import 'package:or_game_app_v4/BuildingConstruction/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/BuildingConstruction/model/BuildingConstructionModel.dart';
import 'package:or_game_app_v4/BuildingConstruction/view/ScreenBuildingConstructionLevel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:or_game_app_v4/view/IconWidget.dart';
import 'package:or_game_app_v4/view/PopUp.dart';
import 'package:or_game_app_v4/view/StatusBar.dart';
import '../../StorageUtil.dart';
import '../../style.dart';

// View Widget to display the game
class ScreenBuildingConstructionGame extends StatefulWidget {

  final List dataInstances;   // contains all the instances of the game
  final int difficultyIndex;  // the index of the difficulty
  final int levelIndex;       // the index of the level
  // ignore: non_constant_identifier_names
  final BuildingConstructionController BCC;  // the Controller of the game

  // Basic Constructor of the class
  ScreenBuildingConstructionGame(this.dataInstances,this.difficultyIndex,this.levelIndex,this.BCC);

  // create a state for the StatefulWidget
  createState() => ScreenBuildingConstructionGameState(this.dataInstances,this.difficultyIndex, this.levelIndex, this.BCC);
}

// state class of the ScreenBuildingConstructionGame
class ScreenBuildingConstructionGameState extends State<ScreenBuildingConstructionGame> {

  List dataInstances;   // contains all the instances of the game
  int difficultyIndex;  // the index of the difficulty
  int levelIndex;       // the index of the level
  // ignore: non_constant_identifier_names
  BuildingConstructionController BCC;   // the Controller of the game

  // Basic Constructor of the class
  ScreenBuildingConstructionGameState(this.dataInstances,this.difficultyIndex, this.levelIndex, this.BCC);

  // overriding the build method
  @override
  Widget build(BuildContext context) {
    // showing PopUpTutorial if it is the first time you get on the tutorial level 1 window
    Future.delayed(Duration.zero, () => showPopUpTutorial(context));
    return Column(
        children : [
          StatusBar(),  // StatusBar
          // Container with all the Widgets displayed
          Container(
              // the rest of the window
              height : MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              width : MediaQuery.of(context).size.width,
              // Stack to put widget over each others
              child : Stack(
                  children : [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _leftScreenPart(),  // leftScreenPart of the game
                          _rightScreenPart(), // rightScreenPart of the game
                        ]
                    ),
                    _Score(),   // score
                    _ReturnButton(),  // return button
                    IconWidget(Axis.vertical,this), // IconWidget vertically
                    _LightBulbIcon(), // lightbulb icon
                    _CheckIcon(),     // check icon
                  ]
              )
          )
        ]
    );
  }

  // elements on the left part of the view
  Widget _leftScreenPart(){
    return Container(
        width : MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height,
        // background image
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/bgDistributionService.png"),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            )
        ),
        child: ListView(
            // scrollable elements of the leftScreenPart of the game
            reverse: true,
            scrollDirection: Axis.vertical,
            children : [
              Container(
                // overlapping again background for aesthetic purposes
                // if not done we get some graphic problems, must be improved
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/backgrounds/bgDistributionService.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      )
                  ),
                  height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
                  alignment: Alignment.center,
                  // contains the elements on the left part of the Screen
                  child: Row(
                      children : [
                        // show the prices of each floor
                        Container(
                            height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
                            width : MediaQuery.of(context).size.width * 0.15,
                            // List of the prices
                            child : ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: BCC.getBCM.getDescriptionOfBuildings.getMaxHeight,
                                itemBuilder: (BuildContext context, int index){
                                  // price of one floor
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
                        // all the buildings
                        Container(
                            height: 15*BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
                            width : MediaQuery.of(context).size.width * 0.5,
                            child : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: BCC.getBCM.getDescriptionOfBuildings.getNumberOfBuildings,
                              itemBuilder: (BuildContext context, int index) {
                                // a building which can accept draggable items
                                return Container(
                                  //padding: const EdgeInsets.only(right: 20),
                                  child: _buildDragTarget(index+1),
                                );
                              },
                            )
                        ),
                      ]
                  )
              )
            ]
        ),
      );
  }

  // elements on the right part of the view
  Widget _rightScreenPart(){
    return Container(
        width : MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 50),
        color : Colors.white70,
        // Drag zone on the right
        child : DragTarget<Client>(
          builder: (BuildContext context, List<Client> incoming, List rejected) {
            // Create a Scrollable Grid (that allows items to have different sizes)
            return StaggeredGridView.countBuilder(
              crossAxisCount: 3,  // 3 items by row max
              staggeredTileBuilder: (int index) => // loop on index to create tiles for each Clients Request
                new StaggeredTile.count(1, BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]].getRequestOfFloors),
              itemCount: BCC.getNumberOfClientsInBuilding(0),
              itemBuilder: (BuildContext context, int index) =>  // loop on index to create draggable for each Clients Request
                  DraggableClient(BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(0))[index]]),
            );
          },
          onWillAccept: (data){ // can be modified to unaccept certain things
            return true;
          },
          onAccept: (data) {  // if accepted update the state
            setState(() {
              BCC.getBCM.assignClientToBuilding(data.getIndex,0);
              BCC.getBCM.updateScore();
            });
          },
          onLeave: (data) { // if not dropped in target
            // nothing
          },
        )
    );
  }

  // widget to display the current score
  Widget _Score(){
    return Positioned(
        bottom : 0,
        right : 0,
        child : Container (
            width : MediaQuery.of(context).size.width * 0.35,
            color: Colors.blueGrey,
            alignment : Alignment.center,
            child : Text('Score ${BCC.getBCM.getScore.toInt()}',style : TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.none))
        )
    );
  }

  // return button to the previous view
  Widget _ReturnButton(){
    return Positioned(
        top : 0,
        right : 0,
        child : Align(
            alignment: Alignment.centerRight,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: ElevatedButton(
                  child: Text(getText('returnButtonText')),
                  style: Style.returnButtonText,
                  onPressed: () {
                    Navigator.of(context).push( //Navigator to ScreenBuildingConstructionLevel widget
                      MaterialPageRoute(builder: (context)=>
                          ScreenBuildingConstructionLevel(this.dataInstances,this.difficultyIndex),
                      ),
                    );
                  },
                )
            )
        )
    );
  }

  // the LightBulbIcon to show Hints
  Widget _LightBulbIcon(){
    return Positioned(
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
              icon: Image.asset('assets/images/icon/lightbulb.png'),
              onPressed: () {
                setState(() {});  // setState to assure the updating of the state
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                  // checking if we are in the tutorial, if yes show specific Hints else General Hints
                  (this.dataInstances[this.difficultyIndex]["difficultyEN"] == 'tutorial') ?
                  TutorialHintPopUp(this.levelIndex+1) : HintPopUp() ,
                );
              },
            ),
          ),
        )
    );
  }

  // check icon to validate the answer
  Widget _CheckIcon(){
    return Positioned(
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
                  //print("Check pressed");
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _CheckPopUp(),
                  );
                },
              )
          ),
        )
    );
  }

  // Special PopUp widget to show winning percentage and if you win or lose
  Widget _CheckPopUp(){
    return AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              height : 100,
              width : 200,
              child : (BCC.getBCM.solutionPercentage()==100) ? Image.asset('assets/images/GagnePerdu/YouWin${StorageUtil.getString('lang')}.png', fit : BoxFit.cover) : Image.asset('assets/images/GagnePerdu/YouLose${StorageUtil.getString('lang')}.png', fit : BoxFit.cover)
          ),
          Text("${getText("winningPercentageText")}: ${BCC.getBCM.solutionPercentage()} %"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(getText("retryText")),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.of(context).push( //Navigateur vers widget
              MaterialPageRoute(builder: (context)=>
                  ScreenBuildingConstructionLevel(this.dataInstances,this.difficultyIndex),
              ),
            );
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(getText("returnText")),
        ),
      ],
    );
  }

  // Building Drag target for the rectangles representing the buildings
  Widget _buildDragTarget(int buildingIndex) {
    return DragTarget<Client>(
      builder: (BuildContext context, List<Client> incoming, List rejected) {
        return Container(
            height: 15 * BCC.getBCM.getDescriptionOfBuildings.getMaxHeight.toDouble(),
            width: 50,
            // padding and margin to increase the size of the Accept zone without increasing the visible rectangle
            padding: EdgeInsets.only(left: 0.0, right: 5.0),
            margin: EdgeInsets.only(left: 0.0, right: 10.0),
            child:
            // the drag zones
            Stack(
                children : [
                  // building visible rectangles
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
                  // building the Draggable inside the rectangles
                  ListView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: BCC
                          .getClientsIndexesInBuilding(buildingIndex)
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return DraggableClient(
                            BCC.getBCM.getClients[(BCC.getClientsIndexesInBuilding(
                                buildingIndex))[index]]);
                      }
                  )
                ]
            )
        );
      },
      onWillAccept: (data) {
        //print("OnWillAccept");
        return true;
      },
      onAccept: (data) {
        //print("Accept $data");
        setState(() {
          BCC.getBCM.assignClientToBuilding(data.getIndex, buildingIndex);
          BCC.getBCM.updateScore();
        });
      },
      onLeave: (data) {
        //print("Not accept");
      },
    );
  }

  // async method to show or not the tutorial PopUp if the player entered for the first time in the tutorial level 1
  showPopUpTutorial(BuildContext context) async {
    // condition
    if(this.dataInstances[this.difficultyIndex]["difficultyEN"] == 'tutorial' &&
        this.levelIndex==0 && StorageUtil.getString('isBuildingConstructionTutorialFirstVisited')=='false') {
      // updating the value of the checked
      await StorageUtil.putString("isBuildingConstructionTutorialFirstVisited", "true");
      // show PopUp
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              BuildingConstructionRulePopUp()
      );
    }
  }

}

// draggable rectangles representing a client request, it takes a client from the model as a parameter
class DraggableClient extends StatelessWidget {

  final Client client;

  // basic constructor
  DraggableClient(this.client);

  @override
  Widget build(BuildContext context) {
    return Draggable<Client>(
        data: client,
        child: ClientIcon(client),
        feedback : ClientIcon(client),
        childWhenDragging: Container()
    );
  }
}

// client icon (what is displayed)
class ClientIcon extends StatelessWidget {
  ClientIcon(this.client);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child : Material(
          child: Container( // main rectangle
              alignment: Alignment.center,
              height: 15.0*client.getRequestOfFloors,
              width : 50,
              child: Column(
                // contour of the rectangles
                children: new List.generate(client.getRequestOfFloors,
                      (index) => Container(
                      alignment: Alignment.center,
                      height: 15,
                      width : 50,
                      decoration: BoxDecoration(
                          color: colorRatio(),  // color of the rectangle depending on a ration calculated about a client request
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


  // generating a Color according to the ration earning/numberOfFloorsDemanded
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

