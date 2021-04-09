import 'package:collection/collection.dart';

/*Class serving as an "interface" to contain raw data collected from a source
to describe an initial problem of BuildingConstruction*/
class BuildingConstructionData
{
  double _solutionValue;    // value of the optimal solution
  int _numberOfBuildings;   // number of buildings' slot available
  int _maxHeight;           // maximum Height of the buildings
  List<double> _pricesOfFloors;          // list of prices of each floor
  List<double> _earningsFromClients;     // list of earnings from clients' requests
  List<int> _requestsOfFloorsFromClients;// list of the number of floors requested by the clients

  // basic constructor
  BuildingConstructionData(
      this._solutionValue,
      this._numberOfBuildings, this._maxHeight, this._pricesOfFloors,
      this._earningsFromClients, this._requestsOfFloorsFromClients);

  //overriding the == operator
  @override
  bool operator ==(other) =>
      other is BuildingConstructionData
          && (other.getSolutionValue == this.getSolutionValue)
          && (other.getNumberOfBuildings == this.getNumberOfBuildings)
          && (other.getMaxHeight == this.getMaxHeight)
          && (ListEquality().equals(other.getPricesOfFloors,this.getPricesOfFloors))
          && (ListEquality().equals(other.getEarningsFromClients,this.getEarningsFromClients))
          && (ListEquality().equals(other.getRequestsOfFloorsFromClients,this.getRequestsOfFloorsFromClients));

  //getters and setters

  List<int> get getRequestsOfFloorsFromClients => _requestsOfFloorsFromClients;
  set requestsOfFloorsFromClients(List<int> value) {
    _requestsOfFloorsFromClients = value;
  }

  List<double> get getEarningsFromClients => _earningsFromClients;
  set earningsFromClients(List<double> value) {
    _earningsFromClients = value;
  }

  List<double> get getPricesOfFloors => _pricesOfFloors;
  set pricesOfFloors(List<double> value) {
    _pricesOfFloors = value;
  }

  int get getMaxHeight => _maxHeight;
  set maxHeight(int value) {
    _maxHeight = value;
  }

  int get getNumberOfBuildings => _numberOfBuildings;
  set numberOfBuildings(int value) {
    _numberOfBuildings = value;
  }

  double get getSolutionValue => _solutionValue;
  set solutionValue(double value) {
    _solutionValue = value;
  }

}




