// based on following example:
// https://fluttercorner.com/how-to-store-and-get-data-from-shared-preferences-in-flutter/
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Storage Class which  maintains all the methods related to the game storage
class StorageUtil {
  static StorageUtil _storageUtil;
  static SharedPreferences _preferences;

  // an asynchronous function to get the Storage
  static Future<StorageUtil> getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  // Constructor
  StorageUtil._();
  // Set the get Instance method to init so it will init every time
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // putString method to put data into preferences
  static Future<bool> putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

  // getString method to get data from preferences
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  // clrString method to clear data from preferences
  static Future<bool> clrString() {
    SharedPreferences prefs = _preferences;
    prefs.clear();
  }

  // storeAlltexts method to store data into the Json file  as Json Objects with three fields :
  // textName / EN / FR which refers to the language chosen
  static storeAllTexts() async {
    List textsData;
    var jsonText = await rootBundle.loadString('assets/texts/texts.json');
    textsData = json.decode(jsonText);
    for(int i =0;i<textsData.length;i++)
    {
      putString(textsData[i]["textName"]+"EN", textsData[i]["EN"]);
      putString(textsData[i]["textName"]+"FR", textsData[i]["FR"]);
    }
  }
}

  // isLangValid method to verify the game
  bool isLangValid(String lang)
  {
    if(lang=="EN"||lang=="FR")
      return true;
    return false;
  }

  // getText method to get text using the textName field as a parameter
  // and based on the language already chosen by the player
  String getText(String textName)
  {
    if(isLangValid(StorageUtil.getString('lang')))
      return StorageUtil.getString(textName+StorageUtil.getString('lang'));
    else
      return "ERROR";
  }