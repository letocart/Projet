
// import
import 'package:flutter_prototype1/data/DistributionServicesData.dart';
import 'package:flutter_prototype1/models/DistributionServicesModel.dart';

class DistributionServicesController {

  DistributionServicesModel DSM;
  DistributionServicesData DSD;
  //DistributionServicesView DSV;

  // constructeur
  DistributionServicesController(
      DistributionServicesModel DSM,
      DistributionServicesData DSD)
  {
    this.DSM = DSM;
    this.DSD = DSD;
  }

  DistributionServicesController.fromData(DistributionServicesData DSD)
  {
    this.DSM = createDSMfromDSD(DSD);
    this.DSD = DSD;
  }

  // getters
  DistributionServicesModel get DSC_DSM {return DSM;}
  DistributionServicesData get DSC_DSD {return DSD;}

  // setters
  void set DSC_DSM(DistributionServicesModel DSM) {this.DSM = DSM;}
  void set DSC_DSD(DistributionServicesData DSD) {this.DSD = DSD;}


}


// methode renvoyant un DistributionServicesModel depuis des donnees DistributionServicesData
DistributionServicesModel createDSMfromDSD(DistributionServicesData DSD)
{
  // assert pour verifier la taille des elements
  assert(DSD.gains.length==DSD.nbs_etages.length);
  assert(DSD.prix_etages.length==DSD.hauteur_max);

  List<Client> clients = [];
  for(int i = 0; i < DSD.gains.length;i++)
  {
    clients.add(Client(DSD.gains[i],DSD.nbs_etages[i]));
  }
  assert(clients.length==DSD.gains.length);
  return DistributionServicesModel(DSD.valeur_solution,
      Immeubles(DSD.nombre_immeubles,DSD.hauteur_max,DSD.prix_etages),
      clients);
}