const String tableNameNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, task, time, listId, isImportant, number
  ];
  static const String id = '_id';
  static const String task = 'task';
  static const String time = 'time';
  static const String listId = 'listId';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
}

class Note {
  final int? id;
  final String task;
  final DateTime createdTime;
  final int listId;
  final bool isImportant;
  final int number;

  const Note({
    this.id,
    required this.task,
    required this.createdTime,
    required this.listId,
    required this.isImportant,
    required this.number,
  });

  Note copy({
    int? id,
    String? title,
    DateTime? createdTime,
    int? listId,
    bool? isImportant,
    int? number,
  }) =>
      Note(
        id: id ?? this.id,
        task: title ?? task,
        createdTime: createdTime ?? this.createdTime,
        listId: listId ?? this.listId,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        task: json[NoteFields.task] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
        listId: json[NoteFields.listId] as int,
        isImportant: (json[NoteFields.isImportant] as int) == 1,
        number: json[NoteFields.number] as int,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.task: task,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.listId: listId,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
      };
}
