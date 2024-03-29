import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPrefManager {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveToken(String token, String value ) async {
    await _prefs.then(( p )=> p.setString( token, value ));
  }

  Future<String?> getToken( String token ) async {
    return await _prefs.then(( p ) => p.getString( token ));
  }

  Future<void> removeToken( String token ) async {
    await _prefs.then((p) => p.remove( token ));
  }

  Future<void> setOnboard() async {
    await _prefs.then(( p ) => p.setBool( CacheKey.ONBOARD.toString(), true ));
  }

  Future<bool?> getOnboard() async {
    return await _prefs.then((p) => p.getBool(CacheKey.ONBOARD.toString()) );
  }

  Future<void> removeOnboard() async {
    await _prefs.then((p) => p.remove( CacheKey.ONBOARD.toString() ));
  }

  Future<dynamic> getItemFromCache( String key, TypeKey type ) async {
    switch ( type ) {
      case TypeKey.bool:
        return await _prefs.then((p) => p.getBool(key));
      case TypeKey.String:
        return await _prefs.then((p) => p.getString(key));
      case TypeKey.Int:
        return await _prefs.then((p) => p.getInt(key));
      case TypeKey.double:
        return await _prefs.then((p) => p.getDouble(key));
      case TypeKey.dynamic:
        return await _prefs.then((p) => p.getStringList(key));
      default:
        return null;
    }
  }

  Future<void> setItemFromCache( String key, TypeKey type, dynamic value ) async {
    switch ( type ) {
      case TypeKey.bool:
        await _prefs.then((p) => p.setBool(key, value));
        break;
      case TypeKey.String:
        await _prefs.then((p) => p.setString(key, value));
        break;
      case TypeKey.Int:
        await _prefs.then((p) => p.setInt(key, value));
        break;
      case TypeKey.double:
        await _prefs.then((p) => p.setDouble(key, value));
        break;
      case TypeKey.dynamic:
        await _prefs.then((p) => p.setStringList(key, value));
        break;
      default:
        return;
    }
  }
}

enum CacheKey {
  TOKEN,
  ONBOARD
}

enum TypeKey {
  bool,
  String,
  Int,
  dynamic,
  double,
}