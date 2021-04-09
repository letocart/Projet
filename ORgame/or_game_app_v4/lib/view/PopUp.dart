// state of PopupRule
import 'package:flutter/material.dart';
import '../StorageUtil.dart';


// method to render a popup which contains the game's rules
PopUp BuildingConstructionRulePopUp(){
  return PopUp(getText('titlePopUpBuildingConstruction'),
      [getText('PopUpBuildingConstructionText1'),
        getText('PopUpBuildingConstructionText2'),
        getText('PopUpBuildingConstructionText3'),
        getText('PopUpBuildingConstructionText4')]);
}

// method to render a popup which contains the game's general explanations
PopUp GeneralRulePopUp(){
  return PopUp(getText('titlePopUpGeneral'),
      [getText('PopUpGeneralText1'),
        getText('PopUpGeneralText2'),
        getText('PopUpGeneralText3')]);
}

// method to render the tutorial popup when pressing the  light bulb button
PopUp TutorialHintPopUp(int index){
  return PopUp(getText('titlePopUpHint'),
      [getText('hinttutorial$index')]);
}

// method to render the popup for other difficulties when pressing the light bulb button
PopUp HintPopUp(){
  return PopUp(getText('titlePopUpHint'),
      [getText('hint1'),
        getText('hint2'),
        getText('hint3')]);
}

// generic Popup listing rules
class PopUp extends StatefulWidget {
  final String title;
  int maxPages;
  final List<String> listOfTexts;

  PopUp(this.title,this.listOfTexts)
  {
    assert(listOfTexts.length>0);
    this.maxPages = listOfTexts.length;
  }
  // Create the Popup state
  @override
  State<StatefulWidget> createState() => PopUpState(this.title,this.maxPages,this.listOfTexts);
}

// The popupState class which represent a popup
// it contains title, currentPage which is set to 0 in the beginning since we can have two types of popups : popup with several pages or without
// it contains also maxPages parameter and listOfTexts which contains the texts displayed in the popup
class PopUpState extends State<PopUp>{
  String title;
  int currentPage = 0;
  int maxPages;
  List<String> listOfTexts;

  PopUpState(this.title,this.maxPages,this.listOfTexts)
  {
    assert(this.maxPages==this.listOfTexts.length);
  }

  // Building UI
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title : Text(this.title),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IndexedStack(
              sizing: StackFit.expand,
              children: <Widget>[
                for ( var i in listOfTexts ) Text(i.toString(),overflow: TextOverflow.ellipsis,  textAlign: TextAlign.justify,)
              ],
              index: currentPage,
            ),
          ],
        ),
        // Navigating from page to page on the popup
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(getText("returnText")),
          ),
          // Using visibility widget in order to not display the navigating buttons unless the popup containes many texts
          new Visibility(
              visible: currentPage > 0,
              child: FlatButton(
                onPressed: () {
                  setState( () =>
                  currentPage = currentPage-1);
                },
                textColor: Theme.of(context).primaryColor,
                child: Text(getText("previousText")),
          )),
          new Visibility(
              visible: currentPage < maxPages-1,
              child: FlatButton(
                onPressed: () {
                  setState( () =>
                  currentPage = currentPage+1);
                },
                textColor: Theme.of(context).primaryColor,
                child: Text(getText("nextText")),
          )),
          new Visibility(
              visible: maxPages>1,
              child: Text("${currentPage+1}/$maxPages")
          ),
        ]
    );
  }
}