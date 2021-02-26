
class DistributionServicesData
{
  double valeur_solution;   // valeur de la solution optimale
  int nombre_immeubles; //nombre d'immeubles au total
  int hauteur_max;      // hauteur maximale de l'immeuble
  List<double> prix_etages; // prix de chaque etage
  List<double> gains;  //quantite d'argent gagne par le service du client
  List<int> nbs_etages;// nombre d'etages demande

  // constructeur
  DistributionServicesData(
    double valeur_solution,
    int nombre_immeubles, int hauteur_max, List<double> prix_etages,
    List<double> gains, List<int> nbs_etages)
  {
    this.valeur_solution= valeur_solution;   // valeur de la solution optimale
    this.nombre_immeubles= nombre_immeubles; //nombre d'immeubles au total
    this.hauteur_max= hauteur_max;      // hauteur maximale de l'immeuble
    this.prix_etages= prix_etages; // prix de chaque etage
    this.gains= gains;  //quantite d'argent gagne par le service du client
    this.nbs_etages= nbs_etages;// nombre d'etages demande
  }

  // getters
  double get DSD_valeur_solution {return valeur_solution;}
  int get DSD_nombre_immeubles{return nombre_immeubles;}
  int get DSD_hauteur{return hauteur_max;}
  List<double> get DSD_prix_etages{return prix_etages;}
  List<double> get DSD_gain{return gains;}
  List<int> get DSD_nb_etages{return nbs_etages;}

  // setters
  void set DSD_valeur_solution(double valeur_solution) {this.valeur_solution = valeur_solution;}
  void set DSD_nombre_immeubles(int nombre_immeubles) {this.nombre_immeubles = nombre_immeubles;}
  void set DSD_hauteur(int hauteur_max) {this.hauteur_max = hauteur_max;}
  void set DSD_prix_etages(List<double> prix_etages) {this.prix_etages = prix_etages;}
  void set DSD_gain(List<double> gains) {this.gains = gains;}
  void set DSD_nb_etages(List<int> nbs_etages) {this.nbs_etages = nbs_etages;}
}

// a implementer la recuperation de la data depuis la BDD pour creer un DistributionServicesData

