import 'package:flutter/material.dart';
import 'package:submission_1/models/note.dart';

class NotesOperation with ChangeNotifier {
  List<Note> _originalNote = [];
  List<Note> _notes = [];

  NotesOperation() {
    Note initialNote = Note(
      title: "🎉 First Note!",
      content: "Welcome to YANA. Please enjoy the app. Thanks!",
      color: Colors.black,
    );

    addNewNote(initialNote);
  }

  set noteSearch(String searchTerm) {
    if (searchTerm.isNotEmpty) {
      filterNotes(searchTerm);
    } else {
      _notes = _originalNote;
    }
  }

  List<Note> get getNotes {
    return _notes;
  }

  void filterNotes(String query) {
    _notes = [];
    _originalNote.forEach((element) {
      if (element.title!.toLowerCase().contains(query)) {
        _notes.add(element);
      }
    });
  }

  void addNewNote(Note note) {
    _originalNote.insert(0, note);
    notifyListeners();
  }
}
