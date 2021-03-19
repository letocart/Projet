//Unit Tests for BuildingConstruction Classes


import 'package:collection/collection.dart';
import 'package:or_game_app_v4/BuildingConstruction/controller/BuildingsConstructionController.dart';
import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';
import 'package:or_game_app_v4/BuildingConstruction/model/BuildingConstructionModel.dart';


// class BuildingConstructionData
assertBCD()
{
  // basic constructor
  BuildingConstructionData BCD = new BuildingConstructionData(300
      , 2, 5, [0, 100, 200, 300, 400]
      , [200, 300], [2, 3]);
  assert(BCD.getSolutionValue==300);
  assert(BCD.getNumberOfBuildings==2);
  assert(BCD.getMaxHeight==5);
  assert(ListEquality().equals(BCD.getPricesOfFloors,[0, 100, 200, 300, 400]));
  assert(ListEquality().equals(BCD.getEarningsFromClients,[200, 300]));
  assert(ListEquality().equals(BCD.getRequestsOfFloorsFromClients,[2, 3]));
  print("assert of BCD terminated successfully");
}

// class BuildingConstructionModel and connected classes
void assertBCM(){

  //test of creation and modification of Client
  Client c1 = new Client(1,150,2);
  Client c2 = new Client(2,300,3);
  assert(c1.getIndex==1);
  assert(c1.getEarning==150);
  assert(c1.getRequestOfFloors==2);
  assert(c2.getIndex==2);
  assert(c2.getEarning==300);
  assert(c2.getRequestOfFloors==3);
  c1.index = 3;
  c1.earning = 100;
  c1.requestOfFloors = 1;
  assert(c1.getIndex==3);
  assert(c1.getEarning==100);
  assert(c1.getRequestOfFloors==1);

  //test of creation and modification of DescriptionOfBuildings
  List<double> priceFloors = [1, 2, 3, 4, 5];
  DescriptionOfBuildings dob = new DescriptionOfBuildings(2, priceFloors.length, priceFloors);
  assert(dob.getNumberOfBuildings==2);
  assert(dob.getMaxHeight==priceFloors.length);
  assert(ListEquality().equals(dob.getPricesOfFloors,[1, 2, 3, 4, 5]));

  priceFloors = [1, 2, 3, 4];
  dob.numberOfBuildings=1;
  dob.maxHeight=priceFloors.length;
  dob.pricesOfFloors = priceFloors;

  assert(dob.getNumberOfBuildings==1);
  assert(dob.getMaxHeight==priceFloors.length);
  assert(ListEquality().equals(dob.getPricesOfFloors,[1, 2, 3, 4]));

  //test of creation and modification of BuildingConstructionModel
  List<Client> clients= [c1,c2]; // list of clients

  //recuperation hauteur_max d'immeubles + prix d'etages
  int maxHeight = 0;
  for(Client c in clients)
  {
    maxHeight += c.getRequestOfFloors;
  }
  priceFloors.length = maxHeight;
  for(int i = 0; i < priceFloors.length;i++)
  {
    priceFloors[i] = i.toDouble()*10;
  }

  DescriptionOfBuildings dob2 = new DescriptionOfBuildings(2, maxHeight, priceFloors);
  BuildingConstructionModel BCM = new BuildingConstructionModel(300, dob2, clients);
  assert(BCM.getSolutionValue==300);
  assert(BCM.getDescriptionOfBuildings==dob2);
  assert(ListEquality().equals(BCM.getClients,clients));
  assert(BCM.getStateOfGame.length==BCM.getClients.length);
  assert(BCM.getStateOfGame[0].length==BCM.getDescriptionOfBuildings.getNumberOfBuildings+1);
  for (int i = 0; i < BCM.getClients.length; i++) {
    for (int j = 0; j < BCM.getDescriptionOfBuildings.getNumberOfBuildings+1; j++) {
      if (j==0){
        assert(BCM.getStateOfGame[i][j]==true);
      } else{
        assert(BCM.getStateOfGame[i][j]==false);
      }
    }
  }

  //test constructor from BCD
  BuildingConstructionData BCD = new BuildingConstructionData(
      200
      , 2, 5, [50, 50, 100, 100, 100]
      , [200, 300], [2, 3]);

  BCM = new BuildingConstructionModel.fromBCD(BCD);
  assert(BCM.getSolutionValue==200);
  assert(BCM.getDescriptionOfBuildings==DescriptionOfBuildings(2, 5, [50, 50, 100, 100, 100]));
  clients = [];
  clients.add(Client(0,200,2));
  clients.add(Client(1,300,3));
  assert(ListEquality().equals(BCM.getClients,clients));
  assert(BCM.getStateOfGame.length==BCM.getClients.length);
  assert(BCM.getStateOfGame[0].length==BCM.getDescriptionOfBuildings.getNumberOfBuildings+1);
  for (int i = 0; i < BCM.getClients.length; i++) {
    for (int j = 0; j < BCM.getDescriptionOfBuildings.getNumberOfBuildings+1; j++) {
      if (j==0){
        assert(BCM.getStateOfGame[i][j]==true);
      } else{
        assert(BCM.getStateOfGame[i][j]==false);
      }
    }
  }

  // test assignClientToBuilding
  assert(BCM.getScore==0);
  /*
  BCM.assignClientToBuilding(0, 1);
  assert(BCM.getStateOfGame[0][0]==false);
  assert(BCM.getStateOfGame[0][1]==true);
  */
  BCM.assignClientToBuilding(0, 2);
  assert(BCM.getStateOfGame[0][0]==false);
  assert(BCM.getStateOfGame[0][2]==true);

  double worst =0;
  for(double price in BCM.getDescriptionOfBuildings.getPricesOfFloors)
  {
    worst += price;
  }
  worst = (worst*BCM.getDescriptionOfBuildings.getNumberOfBuildings)+1;


  // test update score + %solution
  assert(BCM.getScore==0);
  assert(BCM.solutionPercentage()==((BCM.getScore+worst)/(BCM.getSolutionValue+worst)*100).floor());
  BCM.updateScore();
  assert(BCM.getScore==100);
  assert(BCM.solutionPercentage()==((BCM.getScore+worst)/(BCM.getSolutionValue+worst)*100).floor());

  BCM.assignClientToBuilding(1, 1);
  BCM.assignClientToBuilding(0, 2);
  BCM.updateScore();
  assert(BCM.getScore==200);
  assert(BCM.solutionPercentage()==((BCM.getScore+worst)/(BCM.getSolutionValue+worst)*100).floor());
  assert(BCM.solutionPercentage()==100);

  BCM.unassignClient(0);
  BCM.unassignClient(1);
  BCM.updateScore();
  //print(BCM.getStateOfGame);
  //print(BCM.getScore);
  assert(BCM.getScore==0);
  assert(BCM.getStateOfGame[0][0]==true);
  assert(BCM.getStateOfGame[0][2]==false);

  print("assert of BCM terminated successfully");
}

// class BuildingConstructionController
void assertBCC()
{
  BuildingConstructionData BCD = new BuildingConstructionData(
      200
      , 2, 5, [50, 50, 100, 100, 100]
      , [200, 300], [2, 3]);
  BuildingConstructionModel BCM = new BuildingConstructionModel.fromBCD(BCD);

  BuildingConstructionController BCC1 = BuildingConstructionController(BCM, BCD);
  assert(BCC1.getBCM==BCM);
  assert(BCC1.getBCD==BCD);

  BuildingConstructionController BCC2 = BuildingConstructionController.fromBCD(BCD);
  assert(BCC2.getBCM==BuildingConstructionModel.fromBCD(BCD));
  assert(BCC2.getBCD==BCD);

  assert(ListEquality().equals(BCC1.getClientsIndexesInBuilding(0),[0,1]));
  assert(ListEquality().equals(BCC1.getClientsIndexesInBuilding(1),[]));
  assert(ListEquality().equals(BCC1.getClientsIndexesInBuilding(2),[]));
  assert(BCC1.getNumberOfClientsInBuilding(0)==2);
  assert(BCC1.getNumberOfClientsInBuilding(1)==0);
  assert(BCC1.getNumberOfClientsInBuilding(2)==0);
  BCC1.getBCM.assignClientToBuilding(0, 1);
  assert(ListEquality().equals(BCC1.getClientsIndexesInBuilding(0),[1]));
  assert(ListEquality().equals(BCC1.getClientsIndexesInBuilding(1),[0]));
  assert(ListEquality().equals(BCC1.getClientsIndexesInBuilding(2),[]));
  assert(BCC1.getNumberOfClientsInBuilding(0)==1);
  assert(BCC1.getNumberOfClientsInBuilding(1)==1);
  assert(BCC1.getNumberOfClientsInBuilding(2)==0);
  print("assert of BCC terminated successfully");
}
