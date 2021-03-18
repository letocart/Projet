// import

import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:or_game_app_v4/BuildingConstruction/model/BuildingConstructionModel.dart';

class BuildingConstructionController {

  BuildingConstructionModel _DSM;
  BuildingConstructionData _DSD;
  //DistributionServicesView _DSV; a ajouter

  // constructeur
  BuildingConstructionController(
      BuildingConstructionModel DSM,
      BuildingConstructionData DSD)
  {
    this.DSM = DSM;
    this.DSD = DSD;
  }

  BuildingConstructionController.fromDSD(BuildingConstructionData DSD)
  {
    this.DSM = BuildingConstructionModel.fromDSD(DSD);
    this.DSD = DSD;
  }

  BuildingConstructionController.fromIndex(String difficulty, int level)
  {
    //create DSD and DSM from DatabaseManager

    //to replace
    this.DSD = new BuildingConstructionData(300
        , 2, 5, [0, 100, 200, 300, 400]
        , [200, 300, 400, 500, 600, 700, 800], [2, 3, 4, 5, 6, 7, 8]);
    this.DSM = BuildingConstructionModel.fromDSD(this.DSD);
  }

  BuildingConstructionData get DSD => _DSD;
  set DSD(BuildingConstructionData value) {
    _DSD = value;
  }

  DistributionServicesModel get DSM => _DSM;
  set DSM(DistributionServicesModel value) {
    _DSM = value;
  }

  // get the indexes of the clients in a specified building (used in the view)
  List<int> getClientsIndexesInBuilding(int buildingIndex)
  {
    List<int> result = [];
    for(int i =0;i<this.getClients.length;i++)
    {
      if(this.getStateOfGame[i][buildingIndex]==true)
        result.add(i);
    }
    return result;
  }

  // get the number of clients in a specified building (used in the view)
  int getNumberOfClientsInBuilding(int buildingIndex)
  {
    int nb = 0;
    for(int i =0;i<this.getClients.length;i++)
    {
      if(this.getStateOfGame[i][buildingIndex]==true)
        nb++;
    }
    return nb;
  }

}
