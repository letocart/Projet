import 'package:collection/collection.dart'; // import for list comparison

// classe gerant le modele d'un niveau du jeu de "DistributionServices"
class DistributionServicesModel {
  double valeur_solution; // valeur de la solution optimale
  Immeubles immeubles;    // contient les informations par rapport aux emplacement d'immeubles
  List<Client> clients;   // contient les informations par rapport aux clients

  // constructeur
  DistributionServicesModel(double valeur_solution,Immeubles immeubles,List<Client> clients){
    this.valeur_solution = valeur_solution;
    this.immeubles = immeubles;
    this.clients = clients;
  }

  // getters
  double get DSM_valeur_solution {return valeur_solution;}
  Immeubles get DSM_immeubles {return immeubles;}
  List<Client> get DSM_clients {return clients;}

  // setters
  void set DSM_valeur_solution(double valeur_solution) {this.valeur_solution = valeur_solution;}
  void set DSM_immeubles(Immeubles immeubles) {this.immeubles = immeubles;}
  void set DSM_clients(List<Client> clients) {this.clients = clients;}

  @override
  bool operator ==(other) =>
      other is DistributionServicesModel
          && (other.valeur_solution==this.valeur_solution)
          && (other.immeubles==this.immeubles)
          && (ListEquality().equals(other.clients,this.clients));
}

// classe contenant les informations par rapport aux emplacement d'immeubles
class Immeubles {
  int nombre_immeubles; //nombre d'immeubles au total
  int hauteur_max;      // hauteur maximale de l'immeuble
  List<double> prix_etages; // prix de chaque etage

  Immeubles(int nb_imm,int h_max,List<double> pr_et){
    this.nombre_immeubles = nb_imm;
    this.hauteur_max = h_max;
    this.prix_etages = pr_et;
  }
  // getters
  int get imm_nombre{return nombre_immeubles;}
  int get imm_hauteur{return hauteur_max;}
  List<double> get imm_prix_etages{return prix_etages;}

  // setters
  void set imm_nombre(int nombre_immeubles) {this.nombre_immeubles = nombre_immeubles;}
  void set imm_hauteur(int hauteur_max) {this.hauteur_max = hauteur_max;}
  void set imm_prix_etages(List<double> prix_etages) {this.prix_etages = prix_etages;}
}

// classe contenant les informations par rapport a un client
class Client {
  double gain;  //quantite d'argent gagne par le service du client
  int nb_etages;// nombre d'etages demande

  Client(double gain,int nb_etages)
  {
    this.gain = gain;
    this.nb_etages = nb_etages;
  }

  // getters
  double get cli_gain{return gain;}
  int get cli_nb_etages{return nb_etages;}

  // setters
  void set cli_gain(double gain) {this.gain = gain;}
  void set cli_nb_etages(int nb_etages) {this.nb_etages = nb_etages;}

  //overload de l'operateur de comparaison ==
  @override
  bool operator ==(other) =>
      other is Client
          && (other.gain==this.gain)
          && (other.nb_etages==this.nb_etages);

}

// fonction tests unitaires sur l'ensemble des classes du model
void assert_DSM(){

  //assert de creation et modification de clients
  Client c1 = new Client(150,2);
  Client c2 = new Client(300,3);
  assert(c1.cli_gain==150);
  assert(c1.cli_nb_etages==2);
  assert(c2.cli_gain==300);
  assert(c2.cli_nb_etages==3);
  c1.cli_gain = 100;
  c1.cli_nb_etages = 1;
  assert(c1.cli_gain==100);
  assert(c1.cli_nb_etages==1);

  //assert de creation et modification d'immeubles
  List<double> pr_e = [1, 2, 3, 4, 5];
  Immeubles im = new Immeubles(2, pr_e.length, pr_e);
  assert(im.imm_nombre==2);
  assert(im.imm_hauteur==pr_e.length);
  assert(ListEquality().equals(im.imm_prix_etages,[1, 2, 3, 4, 5]));

  pr_e = [1, 2, 3, 4];
  im.imm_nombre=1;
  im.imm_hauteur=pr_e.length;
  im.imm_prix_etages = pr_e;

  assert(im.imm_nombre==1);
  assert(im.imm_hauteur==pr_e.length);
  assert(ListEquality().equals(im.imm_prix_etages,[1, 2, 3, 4]));

  //assert de creation et modification du model
  List<Client> clients= [c1,c2]; // creation liste de clients

  // recuperation hauteur_max d'immeubles + prix d'etages
  int hauteur_max = 0;
  for(Client c in clients)
  {
    hauteur_max += c.cli_nb_etages;
  }
  pr_e.length = hauteur_max;
  for(int i = 0; i < pr_e.length;i++)
  {
    pr_e[i] = i.toDouble()*10;
  }

  Immeubles im2 = new Immeubles(2, hauteur_max, pr_e);
  DistributionServicesModel DSM = new DistributionServicesModel(300, im2, clients);
  assert(DSM.DSM_valeur_solution==300);
  assert(DSM.DSM_immeubles==im2);
  assert(ListEquality().equals(DSM.DSM_clients,clients));
  print("assert of DSM terminated successfully");
}

