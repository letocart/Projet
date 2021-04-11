//imports
import 'package:collection/collection.dart';
import 'package:playing_or/BuildingConstruction/data/BuildingConstructionData.dart';

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
    assert(this._solutionValue>=0); // solution value is positive or equal to 0
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
    //adding clients, each clients has an index starting from 0 to the total number of clients
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
    // checking coherence
    assert(i>=0 && i<this.getClients.length);
    assert(j>=0 && j<=this.getDescriptionOfBuildings.getNumberOfBuildings);
    // unassign the client from any building
    // WARNING <= for the condition and not < because the building 0 represents the fact of not being assigned to a building
    for(int col=0;col<=this.getDescriptionOfBuildings.getNumberOfBuildings;col++)
    {
      this.getStateOfGame[i][col] = false;
    }
    // assign the client to the building j
    this.getStateOfGame[i][j] = true;
  }

  // unassign a client - assign him to the building 0
  void unassignClient(int i)
  {
    assignClientToBuilding(i, 0);
  }

  //update the score according to the clients assignment
  void updateScore()
  {
    this.score = 0;
    int height;
    //for each building from 1 to the number of Buildings /!\ careful <= not <
    for(int j=1; j<=this.getDescriptionOfBuildings.getNumberOfBuildings;j++)
    {
      height = -1;
      // for each client
      for(int i=0;i<this.getClients.length;i++)
      {
        // if the client is assigned we modify the score
        if(this.getStateOfGame[i][j]==true)
        {
          this.score = this.getScore + this.getClients[i].getEarning;
          height+= this.getClients[i].getRequestOfFloors; // we calculate the height of the current building by adding the request
        }
      }

      for(int k=0;k<=height;k++) // according to the height we modify the score
        this.score = this.getScore - this.getDescriptionOfBuildings.getPricesOfFloors[k];
      // assert to check the coherence between the datas
      assert(height<=this.getDescriptionOfBuildings.getMaxHeight);
    }
  }

  // calculate the percentage of the solution
  int solutionPercentage()
  {

    if(this.getSolutionValue<=0) {
      //special case the solution value is equal to 0
      // (it cannot be negative but just in case we test <=)
      if (this.getScore==0) //if score is 0 we return 100%
        return 100;
      else      //else we return 0%
        return 0;
    } else {  //else for normal solutions
      if(this.getScore<0) //if score is negative
        return 0;         //it returns 0%
      else
        return (((this.getScore)/this.getSolutionValue*100).floor()); //it returns the calculated %
    }
  }


  //getters and setters
  double get getSolutionValue => _solutionValue;
  set solutionValue(double value) {
    _solutionValue = value;
  }

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
}

// class containing information about the buildings' slot
class DescriptionOfBuildings {
  int _numberOfBuildings; // total number of buildings
  int _maxHeight;         // max height of the buildings
  List<double> _pricesOfFloors; // list of the prices of each floor

  // basic constructor
  DescriptionOfBuildings(this._numberOfBuildings,this._maxHeight,this._pricesOfFloors);

  // overriding == operator
  @override
  bool operator ==(other) =>
      other is DescriptionOfBuildings
          && (other.getNumberOfBuildings==this.getNumberOfBuildings)
          && (other.getMaxHeight==this.getMaxHeight)
          && (ListEquality().equals(other.getPricesOfFloors,this.getPricesOfFloors));

  // getters and setters
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

// class containing information about clients' requests
class Client {
  int _index;           // each client has an index, from 0 to the number of clients, necessary for the view
  double _earning;      // amount of money given by the client if the request is granted
  int _requestOfFloors; // number of floors requested

  Client(this._index,this._earning,this._requestOfFloors);

  //overriding == operator
  @override
  bool operator ==(other) =>
      other is Client
          && (other.getIndex==this.getIndex)
          && (other.getEarning==this.getEarning)
          && (other.getRequestOfFloors==this.getRequestOfFloors);

  // getters and setters
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


