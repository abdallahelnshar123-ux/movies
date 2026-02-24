import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _themeKey = 'app_theme';
  static const String _langKey = 'app_language';

//todo: save last language and theme => write data
   static Future<void> saveLastAppLanguage(String appLang)async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString(SharedPrefs._langKey, appLang);
   }

//todo: get last language  => read data
   static Future<String> getLastAppLanguage() async {
    final prefs =  await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefs._langKey)?? 'en';
   }


}