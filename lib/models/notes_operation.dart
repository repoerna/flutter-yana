import 'package:flutter/material.dart';
import 'package:submission_1/models/note.dart';

class NotesOperation with ChangeNotifier {
  List<Note> _notes = [];

  NotesOperation() {
    Note initialNote = Note(
      title: "🎉 First Note!",
      content: "Welcome to YANA. Please enjoy the app. Thanks!",
      color: Colors.black,
    );

    addNewNote(initialNote);
  }

  List<Note> get getNotes {
    return _notes;
  }

  void addNewNote(Note note) {
    print('Note on saved ${note.color}');
    _notes.insert(0, note);
    notifyListeners();
  }

//   void addNewNote(String title, String content, Color color) {
//     Note note =
//         Note(title, content, color, NoteState.unspecified, DateTime.now());
//     _notes.add(note);
//     notifyListeners();
//   }
// }
}
