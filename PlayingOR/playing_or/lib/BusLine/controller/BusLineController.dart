import 'package:playing_or/BusLine/data/BusLineData.dart';
import 'package:playing_or/BusLine/model/BusLineModel.dart';

// class controller, managing links and interactions between the view, the model and the data
class BusLineController {
  BusLineData _BLD;
  BusLineModel _BLM;

  // basic constructor
  BusLineController(this._BLM, this._BLD);

  // constructor from BuildingConstructionData
  BusLineController.fromBLD(BusLineData BLD)
  {
    this._BLM = BusLineModel.fromBLD(BLD);
    this._BLD = BLD;
  }

  // TO DO/EXPLAIN - CHECKING (with the view?) That the state Of The Game is a valid solution proposal
  bool isValidSolution()
  {
    // Check the state of Game
    // authorize in the view some movements according to the game rules
    // return if the current state of Game is valid to be a solution

    return false;
    //return true;
  }

  BusLineData get getBLD => _BLD;
  set BLD(BusLineData value) {
    _BLD = value;
  }

  BusLineModel get getBLM => _BLM;
  set BLM(BusLineModel value) {
    _BLM = value;
  }
}