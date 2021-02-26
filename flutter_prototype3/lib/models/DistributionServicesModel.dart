import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prototype1/data/DistributionServicesData.dart'; // import for list comparison

// classe gerant le modele d'un niveau du jeu de "DistributionServices"
class DistributionServicesModel {
  double _valeur_solution; // valeur de la solution optimale
  Immeubles _immeubles;    // contient les informations par rapport aux emplacement d'immeubles
  List<Client> _clients;   // contient les informations par rapport aux clients
  List<List<bool>> _A ; // matrice contenant l'attribution des clients
                      // A[i][j] = true si le client i est attribue a l'immeuble j, false sinon
                      // j = 0 designe que le client n'est attribue a aucun immeuble
                      // !! Faire ATTENTION au niveau des indices
  double _score = 0;


  // constructeur
  DistributionServicesModel(this._valeur_solution,this._immeubles,this._clients) {
    // creation de la matrice A initiale de taille (nbclients,nbimmeubles+1),
    // la premiere colonne a true, le reste a false
    this.A = new List<List<bool>>();
    for (int i = 0; i < clients.length; i++) {
      List<bool> list = new List<bool>();
      for (int j = 0; j < immeubles.nombre_immeubles + 1; j++) {
        if (j == 0) {
          list.add(true);
        } else {
          list.add(false);
        }
      }
      this.A.add(list);
    }
  }

  // constructeur depuis la data, factory pour appeler un autre constructeur
  factory DistributionServicesModel.fromDSD(DistributionServicesData DSD) {
    // assert pour verifier la taille des elements
    assert(DSD.gains.length==DSD.nbs_etages.length);
    assert(DSD.prix_etages.length==DSD.hauteur_max);

    List<Client> clients = [];
    for(int i = 0; i < DSD.gains.length;i++)
    {
      clients.add(Client(DSD.gains[i],DSD.nbs_etages[i]));
    }
    assert(clients.length==DSD.gains.length);
    var result = new DistributionServicesModel(
        DSD.valeur_solution
        ,Immeubles(DSD.nombre_immeubles, DSD.hauteur_max, DSD.prix_etages)
        ,clients);
    return result;
  }

  @override
  bool operator ==(other) =>
      other is DistributionServicesModel
          && (other.valeur_solution==this.valeur_solution)
          && (other.immeubles==this.immeubles)
          && (ListEquality().equals(other.clients,this.clients));

  // modifie la matrice A pour assigner un client i a l'immeuble j
  void assign_client_to_immeuble(int i, int j)
  {
    assert(i>=0 && i<this.clients.length);
    assert(j>=0 && j<=this.immeubles.nombre_immeubles);
    // enleve l'assignement a d'autres immeubles
    for(int col=0;col<=this.immeubles.nombre_immeubles;col++) //ATTENTION <= pas < (car on a 1 immeuble en +, l'immeuble 0 qui represente le non assignement)
    {
        this.A[i][col] = false;
    }
    this.A[i][j] = true;
  }

  // de-assigne un client (le remet dans la colonne 0)
  void unassign_client(int i)
  {
    assign_client_to_immeuble(i, 0);
  }

  void update_score()
  {
    this.score = 0;
    int hauteur;
    //pour chaque immeuble
    for(int j=1; j<this.immeubles.nombre_immeubles+1;j++)
    {
      hauteur = -1;
      // pour chaque client
      for(int i=0;i<this.clients.length;i++)
      {
        if(this.A[i][j]==true) // si le client est assignee on modifie le score
        {
          this.score+= this.clients[i].gain;
          hauteur+= this.clients[i].nb_etages; // on modifie la hauteur de l'immeuble
        }
      }

      for(int k=0;k<=hauteur;k++) // selon la hauteur de l'immeuble on modifie le score
        this.score -= this.immeubles.prix_etages[k];
      assert(hauteur<=this.immeubles.hauteur_max);
    }
  }

  // methode de calcul du pourcentage de reussite par rapport a la valeur solution
  int pourcentage_solution()
  {
    // comme on peut avoir des scores negatifs, on fait un changement de valeur de score pour le calcul du pourcentage
    // on decale le tout du minimum, qui est le prix d'un immeuble entier multiplie par le nombre d'immeuble+1
    // (+1 pour eviter dans le pire cas d'instance avec une division par 0)
    double pire =0;
    for(double prix in this.immeubles.prix_etages)
    {
      pire += prix;
    }
    pire = (pire*this.immeubles.nombre_immeubles)+1;

    return ((this.score+pire)/(this.valeur_solution+pire)*100).floor();
  }

  double get valeur_solution => _valeur_solution;
  set valeur_solution(double value) {
    _valeur_solution = value;
  } //score actuel du jeu


  Immeubles get immeubles => _immeubles;
  set immeubles(Immeubles value) {
    _immeubles = value;
  }

  List<Client> get clients => _clients;
  set clients(List<Client> value) {
    _clients = value;
  }

  List<List<bool>> get A => _A;
  set A(List<List<bool>> value) {
    _A = value;
  }

  double get score => _score;
  set score(double value) {
    _score = value;
  }
}

// classe contenant les informations par rapport aux emplacement d'immeubles
class Immeubles {
  int _nombre_immeubles; //nombre d'immeubles au total
  int _hauteur_max;      // hauteur maximale de l'immeuble
  List<double> _prix_etages;


  Immeubles(int nb_imm,int h_max,List<double> pr_et){
    this.nombre_immeubles = nb_imm;
    this.hauteur_max = h_max;
    this.prix_etages = pr_et;
  }

  @override
  bool operator ==(other) =>
      other is Immeubles
          && (other.nombre_immeubles==this.nombre_immeubles)
          && (other.hauteur_max==this.hauteur_max)
          && (ListEquality().equals(other.prix_etages,this.prix_etages));

  int get nombre_immeubles => _nombre_immeubles;

  set nombre_immeubles(int value) {
    _nombre_immeubles = value;
  } // prix de chaque etage

  int get hauteur_max => _hauteur_max;

  set hauteur_max(int value) {
    _hauteur_max = value;
  }

  List<double> get prix_etages => _prix_etages;

  set prix_etages(List<double> value) {
    _prix_etages = value;
  }
}

// classe contenant les informations par rapport a un client
class Client {
  double _gain;  //quantite d'argent gagne par le service du client
  int _nb_etages;


  Client(double gain,int nb_etages)
  {
    this.gain = gain;
    this.nb_etages = nb_etages;
  }
  //overload de l'operateur de comparaison ==
  @override
  bool operator ==(other) =>
      other is Client
          && (other.gain==this.gain)
          && (other.nb_etages==this.nb_etages);

  double get gain => _gain;

  set gain(double value) {
    _gain = value;
  } // nombre d'etages demande


  int get nb_etages => _nb_etages;

  set nb_etages(int value) {
    _nb_etages = value;
  }
}


