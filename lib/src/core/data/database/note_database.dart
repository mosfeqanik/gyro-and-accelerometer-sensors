import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
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
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    // Create Lists table
    await db.execute('''
      CREATE TABLE lists (
        id $idType,
        title $textType
      )
    ''');

    // Create Notes table with a foreign key referencing the Lists table
    await db.execute('''
      CREATE TABLE $tableNameNotes ( 
        ${NoteFields.id} $idType, 
        ${NoteFields.listId} $integerType,
        ${NoteFields.isImportant} $boolType,
        ${NoteFields.number} $integerType,
        ${NoteFields.title} $textType,
        ${NoteFields.description} $textType,
        ${NoteFields.time} $textType,
        FOREIGN KEY (${NoteFields.listId}) REFERENCES lists (id) ON DELETE CASCADE
      )
    ''');
  }

  // Create a new list
  Future<int> createList(String title) async {
    final db = await instance.database;

    final id = await db.insert(
      'lists',
      {'title': title},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  // Create a new note in a specific list
  Future<Note> createNoteInList(Note note, int listId) async {
    final db = await instance.database;

    final noteWithList = note.copy(listId: listId);

    final id = await db.insert(
      tableNameNotes,
      noteWithList.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return noteWithList.copy(id: id);
  }

  // Read all notes in a specific list
  Future<List<Note>> readNotesInList(int listId) async {
    final db = await instance.database;

    final result = await db.query(
      tableNameNotes,
      where: '${NoteFields.listId} = ?',
      whereArgs: [listId],
    );

    return result.map((json) => Note.fromJson(json)).toList();
  }

  // Read all lists
  Future<List<Map<String, dynamic>>> readAllLists() async {
    final db = await instance.database;
    return await db.query('lists');
  }

  // Update a note
  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNameNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  // Delete a note by its ID
  Future<int> deleteNoteById(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNameNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Delete a list by its ID (deletes all associated notes)
  Future<int> deleteListById(int listId) async {
    final db = await instance.database;

    return await db.delete(
      'lists',
      where: 'id = ?',
      whereArgs: [listId],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
