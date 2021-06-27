import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:markdown_note/model/Note.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum NoteOperationRet {
  SUCCESS,
  NoteIsAlreadyExist,
  NoteIsNotExisted
}

class NoteStore extends StatefulWidget {
  final Widget child;

  NoteStore(this.child);

  @override
  State<StatefulWidget> createState() {
    return _NoteStoreState();
  }

  static _NoteStoreState _getState(BuildContext context) {
    final _NoteStoreScope _noteStoreScope =
      context.inheritFromWidgetOfExactType(_NoteStoreScope);
    return _noteStoreScope._noteStoreState;
  }

  static List<Note> notes(BuildContext context) {
    return _getState(context).notes.values.toList();
  }

  static Future<NoteOperationRet> createNewNote(
      BuildContext context, Note note) async {
    return _getState(context).createNewNote(note);
  }

  static Future<NoteOperationRet> updateExistedNote(
      BuildContext context, String uuid, Note note) async {
    return _getState(context).updateExistedNote(note);
  }

  static Future<NoteOperationRet> removeNote(
      BuildContext context, String uuid) async {
    return _getState(context).removeNote(uuid);
  }
}

class _NoteStoreState extends State<NoteStore> {

  final Map<String, Note> notes = {};

  Future<NoteOperationRet> createNewNote(Note note) async {
    print("createNewNote");
    if (notes.containsKey(note.uuid)) {
      return NoteOperationRet.NoteIsAlreadyExist;
    }

    await _saveNoteToDisk(note);

    setState(() {
      notes[note.uuid] = note;
    });

    return NoteOperationRet.SUCCESS;
  }

  Future<NoteOperationRet> updateExistedNote(Note note) async {
    if (!notes.containsKey(note.uuid)) {
      return NoteOperationRet.NoteIsNotExisted;
    }

    await _saveNoteToDisk(note);

    setState(() {
      notes[note.uuid] = note;
    });

    return NoteOperationRet.SUCCESS;
  }

  Future<NoteOperationRet> removeNote(String uuid) async {
    if (!notes.containsKey(uuid)) {
      return NoteOperationRet.NoteIsNotExisted;
    }

    _removeNoteFromDisk(uuid);

    setState(() {
      notes.remove(uuid);
    });

    return NoteOperationRet.SUCCESS;
  }

  Future<NoteOperationRet> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      for (String key in prefs.getKeys()) {
        notes[key] = Note.fromJson(json.decode(prefs.get(key)));
      }
    });

    return NoteOperationRet.SUCCESS;
  }

  Future<void> _saveNoteToDisk(Note note) async {
    print("_saveNoteToDisk");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(note.uuid, json.encode(note.toJson()));
  }

  Future<void> _removeNoteFromDisk(String uuid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(uuid);
  }

  @override
  Widget build(BuildContext context) {
    return _NoteStoreScope(this, widget.child);
  }
}

class _NoteStoreScope extends InheritedWidget {
  final _NoteStoreState _noteStoreState;

  _NoteStoreScope(this._noteStoreState, Widget child)
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}