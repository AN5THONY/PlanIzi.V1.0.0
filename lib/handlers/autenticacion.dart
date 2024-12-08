import 'package:plan_izi_v2/handlers/sqlite_handler.dart';

class AuthService {
  final SqliteHandler _dbHandler = SqliteHandler();

  // Método para autenticar al usuario
  Future<bool> authenticateUser(String email, String password) async {
    bool isAuthenticated = await _dbHandler.authenticateUser(email, password);
    return isAuthenticated;
  }
}
