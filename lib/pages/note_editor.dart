import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/models/note.dart';
import 'package:submission_1/models/notes_operation.dart';
import 'package:submission_1/widget/color_picker.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  State<StatefulWidget> createState() => _NoteEditorState(note);
}

class _NoteEditorState extends State<NoteEditor> {
  final Note _note;
  final Note _originalNote;

  _NoteEditorState(Note note)
      : this._note = note,
        _originalNote = note.copy(),
        this._titleTextController = TextEditingController(text: note.title),
        this._contentTextController = TextEditingController(text: note.content);

  Color get _noteColor => _note.color ?? Colors.black;

  final TextEditingController _titleTextController;
  final TextEditingController _contentTextController;

  // check if notes modified
  bool get _isModified => _note != _originalNote;

  @override
  void initState() {
    super.initState();
    _titleTextController
        .addListener(() => _note.title = _titleTextController.text);
    _contentTextController
        .addListener(() => _note.content = _contentTextController.text);
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _note,
      child: Consumer<Note>(
        builder: (_, __, ___) => Hero(
          tag: "${_note.created!.millisecondsSinceEpoch}",
          child: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: _noteColor,
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    elevation: 0,
                  ),
              scaffoldBackgroundColor: _noteColor,
              bottomAppBarColor: _noteColor,
            ),
            child: Scaffold(
                appBar: _buildAppBar(context),
                bottomNavigationBar: _buildBottomAppBar(context),
                body: _buildBody(context)),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        iconTheme: IconThemeData(
            color: _note.color == Colors.black ? Colors.white : Colors.black),
        title: Text(
          (_note.title == null && _note.content == null)
              ? "Add New Note"
              : "Edit Note",
          style: TextStyle(
              color: _note.color == Colors.black ? Colors.white : Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      );

  Widget _buildBottomAppBar(BuildContext context) => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        // child: HorizontalColorPicker(),
        child: Container(
          height: 56.0,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  print('on pressed ${_note.color}');

                  if (_note.title == null && _note.content == null) {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      content: Text(
                        'Please insert some text!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.pink,
                      duration: Duration(seconds: 1),
                    ));
                  } else {
                    Provider.of<NotesOperation>(context, listen: false)
                        .addNewNote(_note);
                    Navigator.of(context).pop(true);
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                      content: Text(
                        'Notes created!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.lightGreen,
                      duration: Duration(seconds: 1),
                    ));
                  }
                },
                icon: const Icon(Icons.save_alt),
                color:
                    _note.color == Colors.black ? Colors.white : Colors.black,
              ),
              IconButton(
                onPressed: () => _showNoteBottomSheet(context),
                icon: const Icon(Icons.more_vert),
                color:
                    _note.color == Colors.black ? Colors.white : Colors.black,
              )
            ],
          ),
        ),
      );

  Widget _buildBody(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 80,
        ),
        child: Column(
          children: [
            TextField(
              controller: _titleTextController,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    _note.color == Colors.black ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  counter: const SizedBox(),
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _note.color == Colors.black
                          ? Colors.white
                          : Colors.black)),
              maxLines: null,
              maxLength: 1024,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: TextField(
                controller: _contentTextController,
                style: TextStyle(
                  fontSize: 17,
                  color:
                      _note.color == Colors.black ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration.collapsed(
                    hintText: 'Note',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: _note.color == Colors.black
                          ? Colors.white
                          : Colors.black,
                    )),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ],
        ),
      );

  void _showNoteBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: _noteColor,
      builder: (context) => ChangeNotifierProvider.value(
        value: _note,
        child: Consumer<Note>(
          builder: (_, note, __) => Container(
            color: note.color ?? Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 19),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 8, right: 8, bottom: 16),
                  child: HorizontalColorPicker(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
