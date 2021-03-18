//imports
import 'package:collection/collection.dart';
import 'package:or_game_app_v4/BuildingConstruction/data/BuildingConstructionData.dart';

// class managing the model of the game BuildingConstruction
class BuildingConstructionModel {
  double _solutionValue;    // value of the optimal solution
  DescriptionOfBuildings _descriptionOfBuildings;   // contains different information describing the buildings' slots
  List<Client> _clients;    // list of information about the clients (earning, request)
  List<List<bool>> _stateOfGame ; // matrix of booleans containing the current state of the game
  // stateOfGame[i][j] == true if the client i is assigned to the building j, false otherwise
  // j = 0 represents the fact that the client is not assigned to any building
  // /!\ BE CAREFUL OF THE INDEXES /!\
  double _score = 0; // represents the current score

  // basic constructor
  BuildingConstructionModel(this._solutionValue,this._descriptionOfBuildings,this._clients) {
    // creation and initialization of the matrix stateOfGame of size (numberOfClients,numberOfBuildings+1)
    // first column is true, the rest is false
    this.stateOfGame = new List<List<bool>>();
    for (int i = 0; i < this.getClients.length; i++) {
      List<bool> list = new List<bool>();
      for (int j = 0; j < this.getDescriptionOfBuildings.getNumberOfBuildings + 1; j++) {
        if (j == 0) {
          list.add(true);
        } else {
          list.add(false);
        }
      }
      this.getStateOfGame.add(list);
    }
  }

  // constructor from BuildingConstructionData
  factory BuildingConstructionModel.fromBCD(BuildingConstructionData BCD) {
    // assert to check coherence between data sizes
    assert(BCD.getEarningsFromClients.length==BCD.getRequestsOfFloorsFromClients.length);
    assert(BCD.getPricesOfFloors.length==BCD.getMaxHeight);

    List<Client> clients = [];
    for(int i = 0; i < BCD.getEarningsFromClients.length;i++)
    {
      clients.add(Client(i,BCD.getEarningsFromClients[i],BCD.getRequestsOfFloorsFromClients[i]));
    }
    // another assert to check coherence of data sizes
    assert(clients.length==BCD.getEarningsFromClients.length);

    // factory syntax to call basic constructor to avoid code duplication
    var result = new BuildingConstructionModel(
        BCD.getSolutionValue
        ,DescriptionOfBuildings(BCD.getNumberOfBuildings, BCD.getMaxHeight, BCD.getPricesOfFloors)
        ,clients);
    return result;
    // factory
  }

  // overriding == operator
  @override
  bool operator ==(other) =>
      other is BuildingConstructionModel
          && (other.getSolutionValue==this.getSolutionValue)
          && (other.getDescriptionOfBuildings==this.getDescriptionOfBuildings)
          && (other.getScore==this.getScore)
          && (ListEquality().equals(other.getClients,this.getClients));

  // assign client i to building j in the stateOfGame matrix
  void assignClientToBuilding(int i, int j)
  {
    // checking
    assert(i>=0 && i<this.getClients.length);
    assert(j>=0 && j<=this.getDescriptionOfBuildings.getNumberOfBuildings);
    // enleve l'assignement a d'autres immeubles
    for(int col=0;col<=this.getDescriptionOfBuildings.getNumberOfBuildings;col++) //ATTENTION <= pas < (car on a 1 immeuble en +, l'immeuble 0 qui represente le non assignement)
        {
      this.getStateOfGame[i][col] = false;
    }
    this.getStateOfGame[i][j] = true;
  }

  // de-assigne un client (le remet dans la colonne 0)
  void unassign_client(int i)
  {
    assignClientToBuilding(i, 0);
  }

  List<int> get_clients_indexes_in_immeuble(int immeuble_index)
  {
    List<int> result = [];
    for(int i =0;i<this.getClients.length;i++)
    {
      if(this.getStateOfGame[i][immeuble_index]==true)
        result.add(i);
    }
    return result;
  }

  int nb_client_in(int immeuble)
  {
    int nb = 0;
    for(int i =0;i<this.getClients.length;i++)
    {
      if(this.getStateOfGame[i][immeuble]==true)
        nb++;
    }
    return nb;
  }

  void update_score()
  {
    this.score = 0;
    int hauteur;
    //pour chaque immeuble
    for(int j=1; j<this.getDescriptionOfBuildings.getNumberOfBuildings+1;j++)
    {
      hauteur = -1;
      // pour chaque client
      for(int i=0;i<this.getClients.length;i++)
      {
        if(this.getStateOfGame[i][j]==true) // si le client est assignee on modifie le score
            {
          this.score = this.getScore + this.getClients[i].getEarning;
          hauteur+= this.getClients[i].getRequestOfFloors; // on modifie la hauteur de l'immeuble
        }
      }

      for(int k=0;k<=hauteur;k++) // selon la hauteur de l'immeuble on modifie le score
        this.score = this.getScore - this.getDescriptionOfBuildings.getPricesOfFloors[k];
      assert(hauteur<=this.getDescriptionOfBuildings.getMaxHeight);
    }
  }

  // methode de calcul du pourcentage de reussite par rapport a la valeur solution
  int pourcentage_solution()
  {
    // comme on peut avoir des scores negatifs, on fait un changement de valeur de score pour le calcul du pourcentage
    // on decale le tout du minimum, qui est le prix d'un immeuble entier multiplie par le nombre d'immeuble+1
    // (+1 pour eviter dans le pire cas d'instance avec une division par 0)
    double pire =0;
    for(double prix in this.getDescriptionOfBuildings.getPricesOfFloors)
    {
      pire += prix;
    }
    pire = (pire*this.getDescriptionOfBuildings.getNumberOfBuildings)+1;

    return ((this.getScore+pire)/(this.getSolutionValue+pire)*100).floor();
  }

  double get getSolutionValue => _solutionValue;
  set solutionValue(double value) {
    _solutionValue = value;
  } //score actuel du jeu


  DescriptionOfBuildings get getDescriptionOfBuildings => _descriptionOfBuildings;
  set descriptionOfBuildings(DescriptionOfBuildings value) {
    _descriptionOfBuildings = value;
  }

  List<Client> get getClients => _clients;
  set clients(List<Client> value) {
    _clients = value;
  }

  List<List<bool>> get getStateOfGame => _stateOfGame;
  set stateOfGame(List<List<bool>> value) {
    _stateOfGame = value;
  }

  double get getScore => _score;
  set score(double value) {
    _score = value;
  }
/*
  void print_clients(int immeuble)
  {
    print("Liste des clients dans l'immeuble $immeuble");
    for(int i in get_clients_indexes_in_immeuble(immeuble)) {
      Client c = getClients[i];
      print("Client $i : (gain = ${c.getEarning}, etages = ${c.getRequestOfFloors})");
    }
  }
*/
}

// classe contenant les informations par rapport aux emplacement d'immeubles
class DescriptionOfBuildings {
  int _numberOfBuildings; //nombre d'immeubles au total
  int _maxHeight;      // hauteur maximale de l'immeuble
  List<double> _pricesOfFloors;


  DescriptionOfBuildings(int nb_imm,int h_max,List<double> pr_et){
    this.numberOfBuildings = nb_imm;
    this.maxHeight = h_max;
    this.pricesOfFloors = pr_et;
  }

  @override
  bool operator ==(other) =>
      other is DescriptionOfBuildings
          && (other.getNumberOfBuildings==this.getNumberOfBuildings)
          && (other.getMaxHeight==this.getMaxHeight)
          && (ListEquality().equals(other.getPricesOfFloors,this.getPricesOfFloors));

  int get getNumberOfBuildings => _numberOfBuildings;
  set numberOfBuildings(int value) {
    _numberOfBuildings = value;
  }

  int get getMaxHeight => _maxHeight;
  set maxHeight(int value) {
    _maxHeight = value;
  }

  List<double> get getPricesOfFloors => _pricesOfFloors;
  set pricesOfFloors(List<double> value) {
    _pricesOfFloors = value;
  }
}

// classe contenant les informations par rapport a un client
class Client {
  int _index;
  double _earning;  //quantite d'argent gagne par le service du client
  int _requestOfFloors;


  Client(int index,double gain,int nb_etages)
  {
    this.index = index;
    this.earning = gain;
    this.requestOfFloors = nb_etages;
  }
  //overload de l'operateur de comparaison ==
  @override
  bool operator ==(other) =>
      other is Client
          && (other.getIndex==this.getIndex)
          && (other.getEarning==this.getEarning)
          && (other.getRequestOfFloors==this.getRequestOfFloors);

  int get getIndex => _index;
  set index(int value) {
    _index = value;
  }

  double get getEarning => _earning;
  set earning(double value) {
    _earning = value;
  }

  int get getRequestOfFloors => _requestOfFloors;
  set requestOfFloors(int value) {
    _requestOfFloors = value;
  }
}


