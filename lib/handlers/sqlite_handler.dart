import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHandler {
  /// Obtiene el acceso a la base de datos o la crea si no existe.
  Future<Database> getDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'PlanIzi_database');

    // Crear la base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Método que se ejecuta cuando se crea la base de datos por primera vez.
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS rol (
        id_rol INTEGER PRIMARY KEY,  
        nombre TEXT NOT NULL,                      
        descripcion TEXT                            
      );
    ''');

    // Insertar datos iniciales en la tabla rol
    Batch batch = db.batch();

    batch.insert('rol', {'id_rol': 1, 'nombre': 'freemium', 'descripcion': 'Rol de usuario básico'});
    batch.insert('rol', {'id_rol': 2, 'nombre': 'premium', 'descripcion': 'Rol de usuario que paga para cambiar su plan'});

    await batch.commit(noResult: true);

    await db.execute('''
      CREATE TABLE IF NOT EXISTS usuario (
        id_usuario INTEGER PRIMARY KEY AUTOINCREMENT, 
        id_rol INTEGER DEFAULT 1,
        nombres TEXT,
        apellidos TEXT,
        correo_electronico TEXT NOT NULL UNIQUE, 
        contrasena TEXT NOT NULL,
        genero TEXT NULL,
        ocupacion BOOLEAN DEFAULT NULL,
        descripcion_ocupacion TEXT DEFAULT NULL,
        hobby TEXT DEFAULT NULL,
        comida_favorita TEXT DEFAULT NULL,
        mascota BOOLEAN DEFAULT NULL,
        pais TEXT DEFAULT NULL,
        region TEXT DEFAULT NULL,
        direccion TEXT DEFAULT NULL,
        FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
      );
    ''');
  }

  /// Método para obtener la base de datos.
  Future<Database> get database async {
    return await getDb();
  }

  // Método para autenticar al usuario.
  Future<bool> authenticateUser(String email, String password) async {
    final db = await getDb();

    final List<Map<String, dynamic>> result = await db.query(
      'usuario',
      where: 'correo_electronico = ? AND contrasena = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  // Método para registrar un usuario.
  Future<void> registerUser({
    required String nombres,
    required String apellidos,
    required String correoElectronico,
    required String contrasena,
    required String genero,
  }) async {
    final db = await getDb();

    try {
      await db.insert(
        'usuario',
        {
          'nombres': nombres,
          'apellidos': apellidos,
          'correo_electronico': correoElectronico,
          'contrasena': contrasena,
          'genero': genero,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Error al registrar el usuario: $e');
    }
  }

  // Método para eliminar la base de datos.
  Future<void> deleteDatabaseFile() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'PlanIzi_database');

    try {
      await deleteDatabase(path);
      print('Base de datos eliminada exitosamente.');
    } catch (e) {
      print('Error al eliminar la base de datos: $e');
    }
  }
}