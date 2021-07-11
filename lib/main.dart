import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/models/notes_operation.dart';
import 'package:submission_1/pages/notes_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesOperation(),
      child: MaterialApp(
        title: 'YANA',
        theme: ThemeData(
          brightness: Brightness.dark,
          backgroundColor: Colors.blue[700],
          accentColor: Colors.yellow,
        ),
        home: NoteList(isFirstPage: true),
      ),
    );
  }
}
