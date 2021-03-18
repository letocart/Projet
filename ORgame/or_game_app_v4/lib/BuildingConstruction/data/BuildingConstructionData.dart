//Classe contenant les informations d'une instance et les moyens de les recuperees

import 'package:collection/collection.dart';

class BuildingConstructionData
{
  double _valeur_solution;   // valeur de la solution optimale
  int _nombre_immeubles; //nombre d'immeubles au total
  int _hauteur_max;      // hauteur maximale de l'immeuble
  List<double> _prix_etages; // prix de chaque etage
  List<double> _gains;  //quantite d'argent gagne par le service du client
  List<int> _nbs_etages;// nombre d'etages demande

  // constructeur
  BuildingConstructionData(
      this._valeur_solution,
      this._nombre_immeubles, this._hauteur_max, this._prix_etages,
      this._gains, this._nbs_etages);

  //overload de l'operateur de comparaison ==
  @override
  bool operator ==(other) =>
      other is BuildingConstructionData
          && (other.valeur_solution == this.valeur_solution)
          && (other.nombre_immeubles == this.nombre_immeubles)
          && (other.hauteur_max == this.hauteur_max)
          && (ListEquality().equals(other.prix_etages,this.prix_etages))
          && (ListEquality().equals(other.gains,this.gains))
          && (ListEquality().equals(other.nbs_etages,this.nbs_etages));

  List<int> get nbs_etages => _nbs_etages;

  set nbs_etages(List<int> value) {
    _nbs_etages = value;
  }

  List<double> get gains => _gains;

  set gains(List<double> value) {
    _gains = value;
  }

  List<double> get prix_etages => _prix_etages;

  set prix_etages(List<double> value) {
    _prix_etages = value;
  }

  int get hauteur_max => _hauteur_max;

  set hauteur_max(int value) {
    _hauteur_max = value;
  }

  int get nombre_immeubles => _nombre_immeubles;

  set nombre_immeubles(int value) {
    _nombre_immeubles = value;
  }

  double get valeur_solution => _valeur_solution;

  set valeur_solution(double value) {
    _valeur_solution = value;
  }
}

// a implementer la recuperation de la data depuis la BDD pour creer un DistributionServicesData



