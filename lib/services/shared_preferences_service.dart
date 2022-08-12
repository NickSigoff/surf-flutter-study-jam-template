import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _sharedPreferencesUserToken = 'UserToken';
  static const String _sharedPreferencesUserName = 'UserName';

  Future<bool> setUserTokenSharedPreferences(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        _sharedPreferencesUserToken, token);
  }

  Future<String?> getUserTokenSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_sharedPreferencesUserToken);
  }

  Future<bool> setUserNameSharedPreferences(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        _sharedPreferencesUserName, username);
  }

  Future<String?> getUserNameSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_sharedPreferencesUserName);
  }
}
