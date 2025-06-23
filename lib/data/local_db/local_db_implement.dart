import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';

class LocalDbImplementation implements LocalDb {
  SharedPreferences? _prefs;
  String? _token;
  String? _username;
  String? _password;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString('user_token');
    _username = _prefs?.getString('username');
    _password = _prefs?.getString('password');
  }

  @override
  Future<void> saveCredentials(
    String token,
    String username,
    String password,
  ) async {
    _token = token;
    _username = username;
    _password = password;

    await _prefs?.setString('user_token', token);
    await _prefs?.setString('username', username);
    await _prefs?.setString('password', password);
  }

  @override
  Future<void> clearCredentials() async {
    _token = null;
    _username = null;
    _password = null;

    await _prefs?.remove('user_token');
    await _prefs?.remove('username');
    await _prefs?.remove('password');
  }

  @override
  get isLoggedIn => _token != null;

  @override
  get password => _password?? '';

  @override
  get userToken => _token??'';

  @override
  get username => _username??'';
}
