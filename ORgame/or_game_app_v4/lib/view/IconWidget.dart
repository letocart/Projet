import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:or_game_app_v4/StorageUtil.dart';


class IconWidget extends StatefulWidget {

  State parent; //the parent State Widget
  final Axis direction;

  IconWidget(this.direction,this.parent);

  @override
  State<StatefulWidget> createState() => IconWidgetState(direction,parent);
}

class IconWidgetState extends State<IconWidget>{

  State parent;
  final Axis direction;

  IconWidgetState(this.direction,this.parent);

  // overriding build method
  @override
  Widget build(BuildContext context) {
    // if the axis is horizontal or vertical there are some subtil differences
    // which implies a bit of code duplication below
    if(direction==Axis.horizontal) {
      return buildHorizontalIcons();
    }
    else if(direction==Axis.vertical) {
      return buildVerticalIcons();
    }
    else
    {
      //print("Direction not supported");
      return Container(
          width: 50,
          height: 50,
          color: Colors.red,
          child : Text("Direction not supported")
      );
    }
  }


  Widget buildHorizontalIcons(){
    return Positioned(
        top: 0.0,
        left: 0.0,
        child: Row(
          children: [
            Material(
              color: Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child: IconButton(
                    icon: Image.asset('assets/images/icon/uk.png'),
                    onPressed: () async {
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                      //print("UK flag pressed");
                      await StorageUtil.putString("lang",'EN'); // updating Storage
                      this.parent.setState(() {});              // refreshing parent widget
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                    },
                  )
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child: IconButton(
                    icon: Image.asset('assets/images/icon/fr.png'),
                    onPressed: () async {
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                      //print("French flag pressed");
                      await StorageUtil.putString("lang",'FR');
                      this.parent.setState(() {});
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                    },
                  )
              ),
            ),
              Material(
              color: Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child: IconButton(
                    icon: Image.asset('assets/images/icon/manual.png'),
                    onPressed: () {
                      //print("Manual pressed");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              buildPopUpRule()
                      );
                    },
                  )
              ),
            )
          ],
        )
    );
  }

  Widget buildVerticalIcons(){
    return Positioned(
        top: 0.0,
        left: 0.0,
        child: Column(
          children: [
            Material(
              color : Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder()),
                  child : IconButton(
                    padding: EdgeInsets.only(top : 10, left : 10),
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/images/icon/uk.png'),
                    onPressed: () async {
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                      //print("UK flag pressed");
                      await StorageUtil.putString("lang",'EN'); // updating Storage
                      this.parent.setState(() {});              // refreshing parent widget
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                    },
                  )
              ),
            ),
            Material(
              color : Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child : IconButton(
                    padding: EdgeInsets.only(left : 10),
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/images/icon/fr.png'),
                    onPressed: () async {
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                      //print("French flag pressed");
                      await StorageUtil.putString("lang",'FR');
                      this.parent.setState(() {});
                      //print("Langue actuelle : ${StorageUtil.getString("lang")}");
                    },
                  )
              ),
            ),
            Material(
              color : Colors.transparent,
              child: Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.transparent,
                      shape: CircleBorder()),
                  child : IconButton(
                    padding: EdgeInsets.only(top : 10, left : 10),
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/images/icon/manual.png'),
                    onPressed: () {
                      //print("Manual pressed");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              buildPopUpRule()
                      );
                    },
                  )
              ),
            )
          ],
        )
    );
  }

  // Build the Popup according to which widget we are in
  // it implies that a certain format to name the views is respected
  Widget buildPopUpRule(){

    String title;
    int maxPages;
    List<String> listOfTexts;

    if(this.parent.runtimeType.toString().contains("BuildingConstruction")) { // if we are in a BuildingConstruction game's view
      title  = getText('titlePopUpBuildingConstruction');
      maxPages = 4;
      listOfTexts = [
        getText('PopUpBuildingConstructionText1'),
        getText('PopUpBuildingConstructionText2'),
        getText('PopUpBuildingConstructionText3'),
        getText('PopUpBuildingConstructionText4')];
    }else{  // otherwise
      title = getText('titlePopUpGeneral');
      maxPages = 3;
      listOfTexts = [
        getText('PopUpGeneralText1'),
        getText('PopUpGeneralText2'),
        getText('PopUpGeneralText3')];
    }
    return PopUpRule(title, maxPages, listOfTexts);
  }
}

// generic Popup listing rules
class PopUpRule extends StatefulWidget {
  final String title;
  final int maxPages;
  final List<String> listOfTexts;

  PopUpRule(this.title,this.maxPages,this.listOfTexts);
  @override
  State<StatefulWidget> createState() => PopUpRuleState(this.title,this.maxPages,this.listOfTexts);
}
// state of PopupRule
class PopUpRuleState extends State<PopUpRule>{
  String title;
  int currentPage = 0;
  int maxPages;
  List<String> listOfTexts;

  PopUpRuleState(this.title,this.maxPages,this.listOfTexts)
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
          currentPage > 0 ?
          new FlatButton(
            onPressed: () {
              setState( () =>
              currentPage = currentPage-1);
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(getText("previousText")),
          ) : Container(),
          currentPage < maxPages-1 ?
          new FlatButton(
            onPressed: () {
              setState( () =>
              currentPage = currentPage+1);
            },
            textColor: Theme.of(context).primaryColor,
            child: Text(getText("nextText")),
          ): Container(),
          new Text("${currentPage+1}/$maxPages"),
        ]
    );
  }
}