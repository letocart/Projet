import 'package:collection/collection.dart';

/*Class serving as an "interface" to contain raw data collected from a source
to describe an initial problem of BusLine*/
class BusLineData {

  double _solutionValue;    // value of the optimal solution
  int _numberOfStations;    // number of stations
  List<Coordinates> _stationsCoordinates; // list of the coordinates of the stations
  List<int> _typeOfStations;              //type of the stations
  List<List<bool>> _adjacencyMatrix;   //adjacency matrix of the graph

  BusLineData(this._solutionValue, this._numberOfStations,
      this._stationsCoordinates, this._typeOfStations,
      this._adjacencyMatrix);

  //overriding the == operator
  @override
  bool operator ==(other) =>
      other is BusLineData
          && (other.getSolutionValue == this.getSolutionValue)
          && (other.getNumberOfStations == this.getNumberOfStations)
          && (ListEquality().equals(other.getStationsCoordinates,this.getStationsCoordinates))
          && (ListEquality().equals(other.getTypeOfStations,this.getTypeOfStations))
          && (ListEquality().equals(other.getAdjacencyMatrix,this.getAdjacencyMatrix));


  // getters and setters
  double get getSolutionValue => _solutionValue;
  set solutionValue(double value) {
    _solutionValue = value;
  }

  List<List<bool>> get getAdjacencyMatrix => _adjacencyMatrix;
  set adjacencyMatrix(List<List<bool>> value) {
    _adjacencyMatrix = value;
  }

  List<int> get getTypeOfStations => _typeOfStations;
  set typeOfStations(List<int> value) {
    _typeOfStations = value;
  }

  List<Coordinates> get getStationsCoordinates => _stationsCoordinates;
  set stationsCoordinates(List<Coordinates> value) {
    _stationsCoordinates = value;
  }

  int get getNumberOfStations => _numberOfStations;
  set numberOfStations(int value) {
    _numberOfStations = value;
  }
}

/* simple Coordinates class */
class Coordinates
{
  double _x;
  double _y;

  Coordinates(this._x, this._y);

  double get getX => _x;
  set x(double value) {
    _x = value;
  }

  double get getY => _y;
  set y(double value) {
    _y = value;
  }
}
