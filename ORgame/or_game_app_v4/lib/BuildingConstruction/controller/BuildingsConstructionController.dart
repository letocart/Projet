// imports
import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:or_game_app_v4/BuildingConstruction/model/BuildingConstructionModel.dart';

// class controller, managing links and interactions between the view, the model and the data
class BuildingConstructionController {
  BuildingConstructionModel _BCM;
  BuildingConstructionData _BCD;
  //BuildingConstructionView _BCV; to add

  // basic constructor
  BuildingConstructionController(this._BCM, this._BCD);

  // constructor from BuildingConstructionData
  BuildingConstructionController.fromBCD(BuildingConstructionData BCD)
  {
    this.BCM = BuildingConstructionModel.fromBCD(BCD);
    this.BCD = BCD;
  }

  // constructor from 2 indexes/keys given by the difficulty and the level
  // must be better defined/is for testing purpose as of now
  BuildingConstructionController.fromIndex(String difficulty, int level)
  {
    //create DSD and DSM from DatabaseManager

    //has to be replaced
    this.BCD = new BuildingConstructionData(300
        , 2, 5, [0, 100, 200, 300, 400]
        , [200, 300, 400, 500, 600, 700, 800], [2, 3, 4, 5, 6, 7, 8]);
    this.BCM = BuildingConstructionModel.fromBCD(this.getBCD);
  }

  // getters and setters
  BuildingConstructionData get getBCD => _BCD;
  set BCD(BuildingConstructionData value) {
    _BCD = value;
  }

  BuildingConstructionModel get getBCM => _BCM;
  set BCM(BuildingConstructionModel value) {
    _BCM = value;
  }

  // get the indexes of the clients in a specified building (used in the view)
  List<int> getClientsIndexesInBuilding(int buildingIndex)
  {
    List<int> result = [];
    for(int i =0;i<this.getBCM.getClients.length;i++)
    {
      if(this.getBCM.getStateOfGame[i][buildingIndex]==true)
        result.add(i);
    }
    return result;
  }

  // get the number of clients in a specified building (used in the view)
  int getNumberOfClientsInBuilding(int buildingIndex)
  {
    int nb = 0;
    for(int i =0;i<this.getBCM.getClients.length;i++)
    {
      if(this.getBCM.getStateOfGame[i][buildingIndex]==true)
        nb++;
    }
    return nb;
  }

}
