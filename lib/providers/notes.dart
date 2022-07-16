import 'package:flutter/material.dart';
import 'dart:collection';

class Note {
  
}


class NotesProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Note> _notes = [];

  UnmodifiableListView<Note> get items => UnmodifiableListView(_notes);

  int get totalNotes => _notes.length;

  /// Adds [note] to list of notes. This and [removeAll] are the only ways to modify the
  /// _notes list from the outside.
  void add(Note note) {
    _notes.add(note);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
