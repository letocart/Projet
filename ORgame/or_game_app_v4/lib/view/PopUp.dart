// state of PopupRule
import 'package:flutter/material.dart';

import '../StorageUtil.dart';
import 'IconWidget.dart';

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
  @override
  State<StatefulWidget> createState() => PopUpState(this.title,this.maxPages,this.listOfTexts);
}

PopUp BuildingConstructionRulePopUp(){
  return PopUp(getText('titlePopUpBuildingConstruction'),
      [getText('PopUpBuildingConstructionText1'),
        getText('PopUpBuildingConstructionText2'),
        getText('PopUpBuildingConstructionText3'),
        getText('PopUpBuildingConstructionText4')]);
}

PopUp GeneralRulePopUp(){
  return PopUp(getText('titlePopUpGeneral'),
      [getText('PopUpGeneralText1'),
        getText('PopUpGeneralText2'),
        getText('PopUpGeneralText3')]);
}

PopUp TutorialHintPopUp(int index){
  return PopUp(getText('titlePopUpHint'),
      [getText('hinttutorial$index')]);
}

PopUp HintPopUp(){
  return PopUp(getText('titlePopUpHint'),
      [getText('hint1'),
        getText('hint2'),
        getText('hint3')]);
}
class PopUpState extends State<PopUp>{
  String title;
  int currentPage = 0;
  int maxPages;
  List<String> listOfTexts;

  PopUpState(this.title,this.maxPages,this.listOfTexts)
  {
    assert(this.maxPages==this.listOfTexts.length);
  }
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
                for ( var i in listOfTexts ) Text(i.toString(), textAlign: TextAlign.justify,)
              ],
              index: currentPage,
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(getText("returnText")),
          ),
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