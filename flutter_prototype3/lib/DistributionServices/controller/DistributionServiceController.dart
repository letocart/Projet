
// import

import 'package:flutter_prototype1/DistributionServices/data/DistributionServicesData.dart';
import 'package:flutter_prototype1/DistributionServices/model/DistributionServicesModel.dart';

class DistributionServicesController {

  DistributionServicesModel _DSM;
  DistributionServicesData _DSD;
  //DistributionServicesView _DSV; a ajouter

  // constructeur
  DistributionServicesController(
      DistributionServicesModel DSM,
      DistributionServicesData DSD)
  {
    this.DSM = DSM;
    this.DSD = DSD;
  }

  DistributionServicesController.fromDSD(DistributionServicesData DSD)
  {
    this.DSM = DistributionServicesModel.fromDSD(DSD);
    this.DSD = DSD;
  }

  DistributionServicesController.fromIndex(String difficulty, int level)
  {
    //create DSD and DSM from DatabaseManager

    //to replace
    this.DSD = new DistributionServicesData(300
        , 2, 5, [0, 100, 200, 300, 400]
        , [200, 300, 400, 500, 600, 700, 800], [2, 3, 4, 5, 6, 7, 8]);
    this.DSM = DistributionServicesModel.fromDSD(this.DSD);
  }

  DistributionServicesData get DSD => _DSD;
  set DSD(DistributionServicesData value) {
    _DSD = value;
  }

  DistributionServicesModel get DSM => _DSM;
  set DSM(DistributionServicesModel value) {
    _DSM = value;
  }



}
