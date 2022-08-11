import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _sharedPreferencesUserToken = 'UserToken';

  Future<bool> setUserTokenSharedPreferences(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        _sharedPreferencesUserToken, token);
  }

  Future<String?> getUserTokenSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_sharedPreferencesUserToken);
  }
}
