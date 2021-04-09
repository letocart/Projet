//Unit Tests for Bus line Classes

import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:playing_or/BusLine/controller/BusLineController.dart';
import 'package:playing_or/BusLine/data/BusLineData.dart';
import 'package:playing_or/BusLine/model/BusLineModel.dart';

import '../data/BusLineData.dart';


// defining variables for constructor of Bus Line

// Test instance 1
// Coordinates of differents stations

// for comparing two list
Function equality = const ListEquality().equals;

// class BusLineData
Coordinates c1 = new Coordinates(0.0, 0.0);
Coordinates c2 = new Coordinates(0.0, 0.4);
Coordinates c3 = new Coordinates(2.0, 2.4);
Coordinates c4 = new Coordinates(4.0, 0.0);
Coordinates c5 = new Coordinates(4.0, 4.0);

// List of coordinates
List<Coordinates> coordTest = [c1, c2, c3, c4, c4];

// Solution
double solutionTest = 8.0;

// Type of stations
List<int> typeStationsTest = [2, 1, 0, 0, 3];

// Adjacency matrix
List<bool> l1 = [false, true, true, true, false ];
List<bool> l2 = [true, false, true, false, true ];
List<bool> l3 = [true, true, false, true, true ];
List<bool> l4 = [true, false, true, false, true ];
List<bool> l5 = [false, true, true, true, false ];

List<List<bool>> adjacencyMatrixTest = [ l1, l2, l3, l4, l5];

assertBLD()
{
  // basic constructor
  BusLineData BLD = new  BusLineData(solutionTest, typeStationsTest.length,
      coordTest, typeStationsTest,  adjacencyMatrixTest);

  assert(BLD.getSolutionValue==solutionTest);
  assert(BLD.getNumberOfStations==typeStationsTest.length);
  assert(ListEquality().equals(BLD.getStationsCoordinates,coordTest));
  assert(ListEquality().equals(BLD.getTypeOfStations,typeStationsTest));
  assert(ListEquality().equals(BLD.getAdjacencyMatrix,adjacencyMatrixTest));
  for(int i = 0; i<BLD.getAdjacencyMatrix.length;i++)
  {
    assert(ListEquality().equals(BLD.getAdjacencyMatrix[i],adjacencyMatrixTest[i]));
  }
  print("assert of BLD terminated successfully");
}

// class BusLineModel and connected classes
assertBLM(){
  List<List<bool>> stateOfGameTest = new List<List<bool>>();

  // basic constructor
  BusLineModel BLM = new BusLineModel(solutionTest, typeStationsTest.length,
      coordTest, typeStationsTest,  adjacencyMatrixTest);

  // creating the game's state based on stations
  for (int i = 0; i < BLM.getNumberOfStations; i++)
  {
    List<bool> list = [];
    for (int j = 0; j < BLM.getNumberOfStations; j++)
    {
      list.add(false);
    }
    stateOfGameTest.add(list);
  }
/*
  print("this is real");
  print(BLM.getStateOfGame);
  print("this is test ");
  print(stateOfGameTest);

  print("this is real");
  print(BLM.getAdjacencyMatrix);
  print("this is test ");
  print(adjacencyMatrixTest);
*/
  print(BLM.getStateOfGame.length);
  print(stateOfGameTest.length);

  // Test of creation and modification
  assert(BLM.getSolutionValue==solutionTest);
  assert(BLM.getNumberOfStations==typeStationsTest.length);
  assert(ListEquality().equals(BLM.getStationsCoordinates,coordTest));
  assert(ListEquality().equals(BLM.getTypeOfStations,typeStationsTest));
  //assert(ListEquality().equals(BLM.getAdjacencyMatrix,adjacencyMatrixTest));
  for(int i = 0; i<BLM.getAdjacencyMatrix.length;i++)
  {
    assert(ListEquality().equals(BLM.getAdjacencyMatrix[i],adjacencyMatrixTest[i]));
  }

  for(int i = 0; i<BLM.getStateOfGame.length;i++)
  {
    assert(ListEquality().equals(BLM.getStateOfGame[i],stateOfGameTest[i]));
  }

  //assert(ListEquality().equals(BLM.getStateOfGame,stateOfGameTest));
  // we must not do an ListEquality check on the matrix directly, because it will test == and not List Equality
  assert(BLM.getTotalDistance==0);

  // test distance methods
  // creating a line
  BLM.createLine(0, 4);
  assert(BLM.getStateOfGame[0][4]==true);

  // erasing a line
  BLM.eraseLine(0, 4);

  // calculating distance
  double distance = BLM.calculateDistance(0,2);

  // euclidean distance calculation
  double distanceTest = sqrt( pow(BLM.getStationsCoordinates[2].getX - BLM.getStationsCoordinates[0].getX,2)
      +pow(BLM.getStationsCoordinates[2].getY - BLM.getStationsCoordinates[0].getY,2));

  // test distance
  print(distance);
  print(distanceTest);
  assert(distance == distanceTest);

  // calculating total distance
  double distanceTotal = BLM.calculateTotalDistance();

  double distanceTotalTest = 0;
  for(int i = 0;i<BLM.getNumberOfStations;i++)
  {
    for(int j = 0;j<BLM.getNumberOfStations;j++)
    {
      if (BLM.getStateOfGame[i][j] == true)
        distanceTotalTest += BLM.calculateDistance(i, j);
    }
  }

  // test total distance
  assert(distanceTotal == distanceTotalTest);

  // test updating total distance
  BLM.updateTotalDistance();

  assert(BLM.getTotalDistance == BLM.calculateTotalDistance());
  // calculating solution pourcentage
  int solutionPourcentage = BLM.solutionPercentage();

  int solutionPourcentageTest;
  if(BLM.getTotalDistance>0) {
    solutionPourcentageTest = ((BLM.getSolutionValue / BLM.getTotalDistance) * 100).floor();
  } else {
    solutionPourcentageTest = 0;
  }


  // test solution pourcentage
  assert(solutionPourcentage == solutionPourcentageTest);

  print("assert of BLM terminated successfully");
}

// class BuildingConstructionController
assertBLC()
{
  BusLineData BLD = new BusLineData(solutionTest, typeStationsTest.length,
      coordTest, typeStationsTest,  adjacencyMatrixTest);
  BusLineModel BLM = new BusLineModel.fromBLD(BLD);

  BusLineController BLC1 = BusLineController(BLM , BLD);
  assert(BLC1.getBLM==BLM);
  assert(BLC1.getBLD==BLD);

  BusLineController BLC2 = BusLineController.fromBLD(BLD);
  assert(BLC2.getBLM==BusLineModel.fromBLD(BLD));
  assert(BLC2.getBLD==BLD);


  print("assert of BLC terminated successfully");
}
