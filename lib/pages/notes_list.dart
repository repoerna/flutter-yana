import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_1/models/note.dart';
import 'package:submission_1/models/notes_operation.dart';
import 'package:submission_1/pages/note_editor.dart';
import 'package:submission_1/widget/notes_card.dart';

class NoteList extends StatefulWidget {
  final bool isFirstPage;

  NoteList({
    required this.isFirstPage,
  });

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  bool isSearching = false;

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButton: _buildFab(),
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _NoteListState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchController.text;
        });
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (!widget.isFirstPage) return true;
    return await showDialog(
            context: context,
            builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Do you want to exit the app?"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("Cancel")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text("Exit"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )) ??
        false;
  }

  Widget _buildFab() => FloatingActionButton.extended(
        label: const Text("Add Notes"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditor(
                note: Note(),
              ),
            ),
          );
        },
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: isSearching
                  ? TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(),
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    )
                  : Column(
                      children: <Widget>[Text("Your Notes")],
                    )),
          actions: <Widget>[
            if (!isSearching)
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                },
              ),
            if (isSearching)
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSearching = false;
                  });
                  _searchController.clear();
                },
              ),
          ]);

  Widget _buildBody() => Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          data.noteSearch = _searchText;

          return Scrollbar(
            child: GridView.count(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              children: List.generate(data.getNotes.length,
                  (index) => NotesCard(data.getNotes[index])),
            ),
          );
        },
      );
}
