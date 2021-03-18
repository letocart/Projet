//tests unitaires

// classe DistributionServicesModel
import 'package:collection/collection.dart';


// classe DistributionsServicesData
assert_DSD()
{
  // test constructeur avec arguments
  DistributionServicesData DSD = new DistributionServicesData(300
      , 2, 5, [0, 100, 200, 300, 400]
      , [200, 300], [2, 3]);
  assert(DSD.SolutionValue==300);
  assert(DSD.NumberOfBuildings==2);
  assert(DSD.MaxHeight==5);
  assert(ListEquality().equals(DSD.pricesOfFloors,[0, 100, 200, 300, 400]));
  assert(ListEquality().equals(DSD.earningsFromClients,[200, 300]));
  assert(ListEquality().equals(DSD.requestsOfFloorsFromClients,[2, 3]));
  print("assert of DSD terminated successfully");
}


void assert_DSM(){

  //test de creation et modification de clients
  Client c1 = new Client(1,150,2);
  Client c2 = new Client(2,300,3);
  assert(c1.index==1);
  assert(c1.earning==150);
  assert(c1.requestOfFloors==2);
  assert(c2.index==2);
  assert(c2.earning==300);
  assert(c2.requestOfFloors==3);
  c1.earning = 100;
  c1.requestOfFloors = 1;
  assert(c1.earning==100);
  assert(c1.requestOfFloors==1);

  //test de creation et modification d'immeubles
  List<double> pr_e = [1, 2, 3, 4, 5];
  Immeubles im = new Immeubles(2, pr_e.length, pr_e);
  assert(im.NumberOfBuildings==2);
  assert(im.MaxHeight==pr_e.length);
  assert(ListEquality().equals(im.pricesOfFloors,[1, 2, 3, 4, 5]));

  pr_e = [1, 2, 3, 4];
  im.NumberOfBuildings=1;
  im.MaxHeight=pr_e.length;
  im.pricesOfFloors = pr_e;

  assert(im.NumberOfBuildings==1);
  assert(im.MaxHeight==pr_e.length);
  assert(ListEquality().equals(im.pricesOfFloors,[1, 2, 3, 4]));

  //test de creation et modification du model
  List<Client> clients= [c1,c2]; // creation liste de clients

  //recuperation hauteur_max d'immeubles + prix d'etages
  int hauteur_max = 0;
  for(Client c in clients)
  {
    hauteur_max += c.requestOfFloors;
  }
  pr_e.length = hauteur_max;
  for(int i = 0; i < pr_e.length;i++)
  {
    pr_e[i] = i.toDouble()*10;
  }

  Immeubles im2 = new Immeubles(2, hauteur_max, pr_e);
  DistributionServicesModel DSM = new DistributionServicesModel(300, im2, clients);
  assert(DSM.SolutionValue==300);
  assert(DSM.descriptionOfBuildings==im2);
  assert(ListEquality().equals(DSM.clients,clients));
  assert(DSM.A.length==DSM.clients.length);
  assert(DSM.A[0].length==DSM.descriptionOfBuildings.NumberOfBuildings+1);
  for (int i = 0; i < DSM.clients.length; i++) {
    for (int j = 0; j < DSM.descriptionOfBuildings.NumberOfBuildings+1; j++) {
      if (j==0){
        assert(DSM.A[i][j]==true);
      } else{
        assert(DSM.A[i][j]==false);
      }
    }
  }

  //test constructeur depuis un DSD
  DistributionServicesData DSD = new DistributionServicesData(
      200
      , 2, 5, [50, 50, 100, 100, 100]
      , [200, 300], [2, 3]);

  DSM = new DistributionServicesModel.fromDSD(DSD);
  assert(DSM.SolutionValue==200);
  assert(DSM.descriptionOfBuildings==Immeubles(2, 5, [50, 50, 100, 100, 100]));
  clients = [];
  clients.add(Client(0,200,2));
  clients.add(Client(1,300,3));
  assert(ListEquality().equals(DSM.clients,clients));
  assert(DSM.A.length==DSM.clients.length);
  assert(DSM.A[0].length==DSM.descriptionOfBuildings.NumberOfBuildings+1);
  for (int i = 0; i < DSM.clients.length; i++) {
    for (int j = 0; j < DSM.descriptionOfBuildings.NumberOfBuildings+1; j++) {
      if (j==0){
        assert(DSM.A[i][j]==true);
      } else{
        assert(DSM.A[i][j]==false);
      }
    }
  }

  // test assignation de client a un immeuble + score

  assert(DSM.score==0);
  /*
  DSM.assign_client_to_immeuble(0, 1);
  assert(DSM.A[0][0]==false);
  assert(DSM.A[0][1]==true);
  */
  DSM.assignClientToBuilding(0, 2);
  assert(DSM.A[0][0]==false);
  assert(DSM.A[0][2]==true);

  double pire =0;
  for(double prix in DSM.descriptionOfBuildings.pricesOfFloors)
  {
    pire += prix;
  }
  pire = (pire*DSM.descriptionOfBuildings.NumberOfBuildings)+1;


  // test update score + %solution
  assert(DSM.score==0);
  assert(DSM.pourcentage_solution()==((DSM.score+pire)/(DSM.SolutionValue+pire)*100).floor());
  DSM.update_score();
  assert(DSM.score==100);
  assert(DSM.pourcentage_solution()==((DSM.score+pire)/(DSM.SolutionValue+pire)*100).floor());

  DSM.assignClientToBuilding(1, 1);
  DSM.assignClientToBuilding(0, 2);
  DSM.update_score();
  assert(DSM.score==200);
  assert(DSM.pourcentage_solution()==((DSM.score+pire)/(DSM.SolutionValue+pire)*100).floor());
  assert(DSM.pourcentage_solution()==100);

  DSM.unassign_client(0);
  DSM.unassign_client(1);
  DSM.update_score();
  //print(DSM.A);
  //print(DSM.score);
  assert(DSM.score==0);
  assert(DSM.A[0][0]==true);
  assert(DSM.A[0][2]==false);

  print("assert of DSM terminated successfully");
}

void assert_DSC()
{
  DistributionServicesData DSD = new DistributionServicesData(
      200
      , 2, 5, [50, 50, 100, 100, 100]
      , [200, 300], [2, 3]);
  DistributionServicesModel DSM = new DistributionServicesModel.fromDSD(DSD);

  DistributionServicesController DSC1 = DistributionServicesController(DSM, DSD);
  assert(DSC1.DSM==DSM);
  assert(DSC1.DSD==DSD);

  DistributionServicesController DSC2 = DistributionServicesController.fromDSD(DSD);
  assert(DSC2.DSM==DistributionServicesModel.fromDSD(DSD));
  assert(DSC2.DSD==DSD);

  print("assert of DSC terminated successfully");
}
