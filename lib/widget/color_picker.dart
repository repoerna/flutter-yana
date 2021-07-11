import 'package:collection_ext/iterables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/models/note.dart';

/// Available note background colors
const Iterable<Color> noteColors = [
  Colors.black,
  Color(0xFFF28C82),
  Color(0xFFFABD03),
  Color(0xFFFFF476),
  Color(0xFFCDFF90),
  Color(0xFFA7FEEB),
  Color(0xFFCBF0F8),
  Color(0xFFAFCBFA),
  Color(0xFFD7AEFC),
  Color(0xFFFDCFE9),
  Color(0xFFE6C9A9),
  Color(0xFFE9EAEE),
];

final defaultNoteColor = noteColors.first;

class HorizontalColorPicker extends StatelessWidget {
  Color _currColor(Note note) => note.color ?? Colors.black;

  @override
  Widget build(BuildContext context) {
    Note note = Provider.of<Note>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: noteColors
            .flatMapIndexed((index, color) => [
                  InkWell(
                    child: Container(
                      child: color == _currColor(note)
                          ? const Icon(Icons.check, color: Colors.blueGrey)
                          : null,
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.white)),
                    ),
                    onTap: () {
                      if (color != _currColor(note)) {
                        // print(note.color);
                        note.updateWith(color: color);
                        // print(note.color);
                      }
                    },
                  ),
                  SizedBox(width: index == noteColors.length - 1 ? 10 : 14),
                ])
            .asList(),
      ),
    );
  }
}
