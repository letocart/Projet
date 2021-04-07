// based on following example:
// https://fluttercorner.com/how-to-store-and-get-data-from-shared-preferences-in-flutter/
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static StorageUtil _storageUtil;
  static SharedPreferences _preferences;

  static Future<StorageUtil> getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageUtil._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // put string
  static Future<bool> putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  // clear string
  static Future<bool> clrString() {
    SharedPreferences prefs = _preferences;
    prefs.clear();
  }

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

bool isLangValid(String lang)
{
  if(lang=="EN"||lang=="FR")
    return true;
  return false;
}

String getText(String textName)
{
  if(isLangValid(StorageUtil.getString('lang')))
    return StorageUtil.getString(textName+StorageUtil.getString('lang'));
  else
    return "ERROR";
}