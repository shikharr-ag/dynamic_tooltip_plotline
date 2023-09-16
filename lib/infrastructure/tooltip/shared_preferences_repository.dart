import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
}
