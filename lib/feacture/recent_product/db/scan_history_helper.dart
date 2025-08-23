import 'package:nutriscan/core/constants/app_linker.dart';

class ScanHistoryHelper {
  static final ScanHistoryHelper _instance = ScanHistoryHelper._internal();
  factory ScanHistoryHelper() => _instance;
  ScanHistoryHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('scan_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE scan_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT,
        brand TEXT,
        calories REAL,
        dateTime TEXT
      )
    ''');
  }

  Future<void> insertScan(Map<String, dynamic> scan) async {
    final db = await database;
    await db.insert('scan_history', scan);
  }

  Future<List<Map<String, dynamic>>> getScans() async {
    final db = await database;
    return await db.query('scan_history', orderBy: 'dateTime DESC');
  }

  Future<void> clearAllScans() async {
    final db = await database;
    await db.delete('scan_history');
  }
}
