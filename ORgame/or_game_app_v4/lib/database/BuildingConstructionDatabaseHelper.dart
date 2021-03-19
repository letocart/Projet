import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BuildingConstructionDatabaseHelper{

  static final _dbName = 'bdd/JeuImmeubleRO.db';
  static final _dbVersion = 1;

  // Table client
  static final _tableClient = 'Client';
  static final columnIdClient='id_client';
  static final columnNbEtage='nb_etage';
  static final columnGain='gain';

  // Table Immeuble Emplacement
  static final _tableEmpImmeubles = 'Emp_immeubles';
  static final columnIdEmpImmeubles = 'id_emp_immeubles';
  static final columnNbEmpImmeubles = 'nb_emp_immeubles';
  static final columnHauteurMax = 'hauteur_max';
  static final columnPrixEtage = 'prix_etage';

  // Table Solution Immeuble
  static final _tableSolutionImmeuble = 'Solution_immeuble';
  static final columnIdSolution = 'id_solution';
  static final columnValeur = 'valeur';

  // Table Jeu Immeuble
  static final _tableJeuImmeuble = 'Jeu_immeuble';
  static final columnIdJeuImmeuble = 'id_jeu_immeuble';
  static final columnDescription = 'description';
  static final columnDifficulte  = 'difficulte';

  // make the class a singleton class : we need to have one instance of the database
  BuildingConstructionDatabaseHelper._privateConstructor();
  static final BuildingConstructionDatabaseHelper instance = BuildingConstructionDatabaseHelper._privateConstructor();


  // Initialize the database
  static Database _database;

  // Getter
  Future<Database> get database async {
    if(_database!=null) return _database;

    // else
    _database = await _initiateDatabase();
    return _database;

  }

  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    print('avant');
    await openDatabase(path,version: _dbVersion,
        onCreate: _onCreate
    );
    print('après');
  }

   Future _onCreate(Database db, int version){
    // Création de la table Client
    db.query(
      '''
      CREATE TABLE $_tableClient( 
      $columnIdClient INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnNbEtage TEXT,
      $columnGain TEXT
      )  
      '''
    );
    // Création de la table Emplacement Immeuble
    db.query(
        '''
      CREATE TABLE $_tableEmpImmeubles( 
      $columnIdEmpImmeubles INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnNbEmpImmeubles INTEGER,
      $columnHauteurMax INTEGER,
      $columnPrixEtage TEXT
      )  
      '''
    );

    // Création de la table Solution Jeu
    db.query(
        '''
      CREATE TABLE $_tableSolutionImmeuble( 
      $columnIdSolution INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnValeur INTEGER,
      )  
      '''
    );

    // Création de la table de base : Jeu Immeuble
    db.query(
        '''
      CREATE TABLE $_tableJeuImmeuble( 
      $columnIdJeuImmeuble INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnDifficulte TEXT,
      $columnDescription TEXT,
      $columnIdSolution INTEGER, 
      $columnIdEmpImmeubles INTEGER,
      $columnIdClient INTEGER,
      FOREIGN KEY($columnIdSolution) REFERENCES $_tableSolutionImmeuble($columnIdSolution),
      FOREIGN KEY($columnIdClient) REFERENCES $_tableClient($columnIdClient),
      FOREIGN KEY($columnIdEmpImmeubles) REFERENCES $_tableEmpImmeubles($columnIdEmpImmeubles),
      CHECK($columnDifficulte = 'Tutorial' OR $columnDifficulte ='Easy' OR $columnDifficulte ='Normal' OR $columnDifficulte ='Hard' OR $columnDifficulte ='Insane')
      )  
      '''
    );
  }

  // Insertion
  Future<int> insert(Map<String, dynamic> row, final _table) async {
    Database db = await instance.database;
    return await db.insert(_table, row);
  }




  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(_tableJeuImmeuble);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $_tableJeuImmeuble'));
  }

}