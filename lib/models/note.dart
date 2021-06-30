import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Note extends ChangeNotifier {
  // final String id;
  String? title;
  String? content;
  Color? color;
  NoteState? state;
  final DateTime? created;
  DateTime? modified;

  Note({
    this.title,
    this.content,
    Color? color,
    NoteState? state,
    DateTime? created,
    DateTime? modified,
  })  : this.created = created ?? DateTime.now(),
        this.modified = modified ?? DateTime.now(),
        this.color = color ?? Colors.black;

  bool get isPinned => state == NoteState.pinned;
  bool get isNotEmpty =>
      title?.isNotEmpty == true || content?.isNotEmpty == true;

  int get stateValue => (state ?? NoteState.unspecified).index;

  String get strLastModified => DateFormat.MMMd().format(modified!);

  Note updateWith({
    String? title,
    String? content,
    Color? color,
    NoteState? state,
    bool updateTimestamp = true,
  }) {
    if (title != null) this.title = title;
    if (content != null) this.content = content;
    if (color != null) this.color = color;
    if (state != null) this.state = state;
    if (updateTimestamp) modified = DateTime.now();
    notifyListeners();
    return this;
  }

  void update(Note other, {bool updateTimestamp = true}) {
    title = other.title;
    content = other.content;
    color = other.color;
    state = other.state;

    if (updateTimestamp || other.modified == null) {
      modified = DateTime.now();
    } else {
      modified = other.modified;
    }
    notifyListeners();
  }

  Note copy({bool updateTimestamp = false}) => Note(
        // id: id,
        created:
            (updateTimestamp || created == null) ? DateTime.now() : created,
      )..update(this, updateTimestamp: updateTimestamp);
}

enum NoteState {
  unspecified,
  pinned,
  archived,
  deleted,
}
