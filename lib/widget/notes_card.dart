import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:submission_1/models/note.dart';
import 'package:submission_1/pages/note_editor.dart';

class NotesCard extends StatelessWidget {
  final Note note;

  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteEditor(
              note: note,
            ),
          ),
        );
      },
      child: Hero(
        tag: "${note.created!.millisecondsSinceEpoch}",
        child: DefaultTextStyle(
          style: TextStyle(
              color: note.color == Colors.black ? Colors.black : note.color,
              fontSize: 16),
          child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            height: 150,
            decoration: BoxDecoration(
              color: note.color == Colors.black ? Colors.black : note.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title ?? "",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: note.color == Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  // flex: 1,
                  child: Text(
                    note.content ?? "",
                    style: TextStyle(
                      fontSize: 17,
                      color: note.color == Colors.black
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  // ),
                ),
                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('MMM d, yyyy').format(note.created!),
                      style: TextStyle(
                        fontSize: 15,
                        color: note.color == Colors.black
                            ? Colors.grey
                            : Colors.brown,
                      ),
                    ),
                    Text(
                      DateFormat('h:mm a').format(note.created!),
                      style: TextStyle(
                        fontSize: 15,
                        color: note.color == Colors.black
                            ? Colors.grey
                            : Colors.brown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
