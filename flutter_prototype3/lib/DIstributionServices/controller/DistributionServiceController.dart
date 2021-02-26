
// import

import 'package:flutter_prototype1/DIstributionServices/data/DistributionServicesData.dart';
import 'package:flutter_prototype1/DIstributionServices/model/DistributionServicesModel.dart';

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



  DistributionServicesData get DSD => _DSD;
  set DSD(DistributionServicesData value) {
    _DSD = value;
  }

  DistributionServicesModel get DSM => _DSM;
  set DSM(DistributionServicesModel value) {
    _DSM = value;
  }
}
