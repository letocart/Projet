// imports
import 'package:playing_or/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:playing_or/BuildingConstruction/model/BuildingConstructionModel.dart';

// class controller, managing links and interactions between the view, the model and the data
class BuildingConstructionController {
  BuildingConstructionModel _BCM;
  BuildingConstructionData _BCD;

  // basic constructor
  BuildingConstructionController(this._BCM, this._BCD);

  // constructor from BuildingConstructionData
  BuildingConstructionController.fromBCD(BuildingConstructionData BCD)
  {
    this.BCM = BuildingConstructionModel.fromBCD(BCD);
    this.BCD = BCD;
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
