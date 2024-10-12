import 'package:flutter/material.dart';
import '../../../core/data/database/note_database.dart';
import '../../../core/data/model/note.dart';

class TodoNoteProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;
  var list;

  bool _isValidLength = false;

  bool get isValidLength => _isValidLength;

  set isValidLength(bool value) {
    _isValidLength = value;
    notifyListeners();
  }

  void checkLength(String value) {
    _isValidLength = value.length >= 8;
    notifyListeners();
  }

  Future<void> createNoteList({required String listTitle}) async {
    await NotesDatabase.instance.createList(listTitle);
    loadNoteList();
    notifyListeners();
  }

  Future<void> loadNoteList() async {
    list = await NotesDatabase.instance.readAllLists();
    notifyListeners();
  }

  Future<void> loadNotes(int listId) async {
    _notes = await NotesDatabase.instance.readNotesInList(listId);
    notifyListeners();
  }

  Future<void> addNoteToList({Note? note, int? listId}) async {
    await NotesDatabase.instance.createNoteInList(note!, listId!);
    await loadNotes(listId);
    notifyListeners();
  }

  Future<void> updateNote({Note? note, int? listId}) async {
    await NotesDatabase.instance.updateNoteInList(note!, listId!);
    await loadNotes(listId);
    notifyListeners();
  }

  Future<void> deleteNoteById({int? noteId, int? listId}) async {
    await NotesDatabase.instance.deleteNoteInList(noteId!, listId!);
    await loadNotes(listId!);
  }

  Future<void> deleteListAndNotes(int listId) async {
    await NotesDatabase.instance.deleteListById(listId);
    _notes = [];
    notifyListeners();
  }
}
