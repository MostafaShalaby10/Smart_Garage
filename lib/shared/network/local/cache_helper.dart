
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper{

  static late SharedPreferences sharedPreferences;
  static bool stateMode = false;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();

  }






  // remove key
  static Future<bool>  clearData({
    required String key
}) async
  {
   return await sharedPreferences.remove(key);
  }


  // return data value
  static dynamic getData({
    required String key
  })
  {
    return sharedPreferences.get(key);
  }


  // save any data
  static Future<bool> SaveData({
    required String key,
    required dynamic value
  })async
  {
    if(value is bool)
      return await sharedPreferences.setBool(key,value );
    else if(value is int)
      return await sharedPreferences.setInt(key,value );
    else if(value is double)
      return await sharedPreferences.setDouble(key,value );
    else
      return await sharedPreferences.setString(key,value );


  }







  // change mode app themes
  static Future<bool> putBool({
    required String key,
    required bool value
  })async
  {
    stateMode = true;
    return await sharedPreferences.setBool(key,value );

  }


  static bool? getBool({
    required String key
  })
  {
    return sharedPreferences.getBool(key);
  }
}

