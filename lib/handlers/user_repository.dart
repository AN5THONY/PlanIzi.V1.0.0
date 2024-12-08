import 'package:plan_izi_v2/handlers/sqlite_handler.dart';

class RoleRepository {
  final SqliteHandler _sqliteHandler = SqliteHandler();

  // Método para obtener todos los roles
  Future<List<Map<String, dynamic>>> getRoles() async {
    final db = await _sqliteHandler.database;
    return await db.query('rol');
  }
}