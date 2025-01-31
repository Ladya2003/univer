import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model/Entities.dart';
import 'dart:developer';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hobby_entities.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    log("Initializing database at path: $path");  // Лог для отслеживания пути базы данных
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    log("Creating table hobby_entity"); // Лог для отслеживания создания таблицы
    await db.execute('''CREATE TABLE hobby_entity (
      ${HobbyEntityFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${HobbyEntityFields.name} TEXT NOT NULL,
      ${HobbyEntityFields.type} TEXT NOT NULL,
      ${HobbyEntityFields.description} TEXT NOT NULL
    )''');
  }

  Future<HobbyEntity> create(HobbyEntity entity) async {
    final db = await instance.database;
    final id = await db.insert(tableHobbyEntity, entity.toJson());
    return entity.copy(id: id);
  }

  Future<HobbyEntity> readEntity(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableHobbyEntity,
      columns: HobbyEntityFields.values,
      where: '${HobbyEntityFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return HobbyEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<HobbyEntity>> readAllEntities() async {
    final db = await instance.database;
    final result = await db.query(tableHobbyEntity);
    return result.map((json) => HobbyEntity.fromJson(json)).toList();
  }

  Future<int> update(HobbyEntity entity) async {
    final db = await instance.database;
    return db.update(
      tableHobbyEntity,
      entity.toJson(),
      where: '${HobbyEntityFields.id} = ?',
      whereArgs: [entity.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      tableHobbyEntity,
      where: '${HobbyEntityFields.id} = ?',
      whereArgs: [id],
    );
  }
}
