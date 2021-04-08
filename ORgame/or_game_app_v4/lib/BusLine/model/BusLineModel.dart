//imports
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:or_game_app_v4/BusLine/data/BusLineData.dart';

// class managing the model of the game BusLine
class BusLineModel
{
  double _solutionValue;    // value of the optimal solution
  int _numberOfStations;    // number of stations
  List<Coordinates> _stationsCoordinates; // list of the coordinates of the stations
  List<int> _typeOfStations;              //type of the stations
  List<List<bool>> _adjacencyMatrix;   //adjacency matrix of the graph
  List<List<bool>> _stateOfGame;
  /* matrix representing the state of the game
  size numberOfStations*numberOfStations
  stateOfGame[i][j] = true if there is an from i to j
  (sort of oriented matrix)
  */
  double _totalDistance=0;

  //overriding the == operator
  @override
  bool operator ==(other) {
    if (!(other is BusLineModel
        && (other.getSolutionValue == this.getSolutionValue)
        && (other.getNumberOfStations == this.getNumberOfStations)
        && (ListEquality().equals(other.getStationsCoordinates,this.getStationsCoordinates))
        && (ListEquality().equals(other.getTypeOfStations,this.getTypeOfStations))
        && (other.getAdjacencyMatrix.length==this.getAdjacencyMatrix.length))
        && (other.getStateOfGame.length==this.getStateOfGame.length))
      return false;
    for(int i = 0;i<this.getStateOfGame.length;i++) {
      if (!(ListEquality().equals(other.getStateOfGame[i], this.getStateOfGame[i])))
        return false;
    }
    for(int i = 0;i<this.getAdjacencyMatrix.length;i++) {
      if (!(ListEquality().equals(other.getStateOfGame[i], this.getStateOfGame[i])))
        return false;
    }
    return true;
  }


  BusLineModel(this._solutionValue, this._numberOfStations,
      this._stationsCoordinates, this._typeOfStations,
      this._adjacencyMatrix)
  {
    // creation and initialization of the matrix stateOfGame
    // everything is false
    this.stateOfGame = new List<List<bool>>();
    List<bool> list;
    for (int i = 0; i < this.getNumberOfStations; i++)
    {
      list = [];
      for (int j = 0; j < this.getNumberOfStations; j++)
      {
        list.add(false);
      }
      this.getStateOfGame.add(list);
    }
  }

  // Constructor from BusLineData
  factory BusLineModel.fromBLD(BusLineData BLD)
  {
    // assert to check coherence of data sizes
    assert(BLD.getNumberOfStations==BLD.getStationsCoordinates.length);
    assert(BLD.getNumberOfStations==BLD.getTypeOfStations.length);
    assert(BLD.getNumberOfStations==BLD.getAdjacencyMatrix.length);
    assert(BLD.getNumberOfStations==BLD.getAdjacencyMatrix[0].length);

    // factory syntax to call basic constructor to avoid code duplication
    var result = new BusLineModel(BLD.getSolutionValue,BLD.getNumberOfStations,
        BLD.getStationsCoordinates, BLD.getTypeOfStations,BLD.getAdjacencyMatrix);
    return result;
    // factory
  }

  // Change the stateOfGame Matrix to create a line from i to j
  void createLine(int i,int j)
  {
    // checking coherence
    assert(i>=0 && i<this.getNumberOfStations);
    assert(j>=0 && j<this.getNumberOfStations);
    this.getStateOfGame[i][j] = true;
  }

  // Change the stateOfGame Matrix to erase a line from i to j
  void eraseLine(int i,int j)
  {
    // checking coherence
    assert(i>=0 && i<this.getNumberOfStations);
    assert(j>=0 && j<this.getNumberOfStations);
    this.getStateOfGame[i][j] = false;
  }

  // calculate the distance between two vertices of the matrix
  double calculateDistance(int i, int j)
  {
    assert(i>=0 && i<this.getNumberOfStations);
    assert(j>=0 && j<this.getNumberOfStations);
    double distance = 0;
    // euclidean distance calculation
    distance = sqrt(
        pow(this.getStationsCoordinates[j].getX - this.getStationsCoordinates[i].getX,2)
       +pow(this.getStationsCoordinates[j].getY - this.getStationsCoordinates[i].getY,2));
    return distance;
  }

  double calculateTotalDistance()
  {
    double totalDistance = 0;
    for(int i = 0;i<this.getNumberOfStations;i++)
    {
      for(int j = 0;j<this.getNumberOfStations;j++)
      {
        if (this.getStateOfGame[i][j] == true)
          totalDistance += this.calculateDistance(i, j);
      }
    }
    return totalDistance;
  }

  void updateTotalDistance()
  {
    this.totalDistance = this.calculateTotalDistance();
  }

  // calculate the percentage of the solution
  int solutionPercentage()
  {
    if(this.getTotalDistance>0)
      return ((this.getSolutionValue/this.getTotalDistance)*100).floor();
    return 0;
  }

  // getters and setters
  double get getTotalDistance => _totalDistance;
  set totalDistance(double value) {
    _totalDistance = value;
  }

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

  List<List<bool>> get getStateOfGame => _stateOfGame;
  set stateOfGame(List<List<bool>> value) {
    _stateOfGame = value;
  }
}