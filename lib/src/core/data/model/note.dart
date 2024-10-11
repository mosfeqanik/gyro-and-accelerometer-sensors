const String tableNameNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, macAddress, ipAddress, title, description, time, listId, isImportant, number
  ];

  static const String id = '_id';
  static const String macAddress = 'macAddress';
  static const String ipAddress = 'ipAddress';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
  static const String listId = 'listId';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
}

class Note {
  final int? id;
  final String? macAddress;
  final String? ipAddress;
  final String title;
  final String description;
  final DateTime createdTime;
  final int listId;
  final bool isImportant;
  final int number;

  const Note({
    this.id,
    this.macAddress,
    this.ipAddress,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.listId,
    required this.isImportant,
    required this.number,
  });

  Note copy({
    int? id,
    String? macAddress,
    String? ipAddress,
    String? title,
    String? description,
    DateTime? createdTime,
    int? listId,
    bool? isImportant,
    int? number,
  }) =>
      Note(
        id: id ?? this.id,
        macAddress: macAddress ?? this.macAddress,
        ipAddress: ipAddress ?? this.ipAddress,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        listId: listId ?? this.listId,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    macAddress: json[NoteFields.macAddress] as String?,
    ipAddress: json[NoteFields.ipAddress] as String?,
    title: json[NoteFields.title] as String,
    description: json[NoteFields.description] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),
    listId: json[NoteFields.listId] as int,
    isImportant: (json[NoteFields.isImportant] as int) == 1,
    number: json[NoteFields.number] as int,
  );

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.title: title,
    NoteFields.macAddress: macAddress,
    NoteFields.ipAddress: ipAddress,
    NoteFields.description: description,
    NoteFields.time: createdTime.toIso8601String(),
    NoteFields.listId: listId,
    NoteFields.isImportant: isImportant ? 1 : 0,
    NoteFields.number: number,
  };
}
