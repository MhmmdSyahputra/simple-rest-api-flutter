import 'package:flutter/material.dart';
import 'package:rest_api_flutter/model/note_model.dart';
import 'package:rest_api_flutter/service/note_service.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> _noteList = [];
  List<NoteModel> _filteredNoteList = [];

  List<NoteModel> get noteList => _noteList;
  List<NoteModel> get filteredNoteList => _filteredNoteList;

  Future<void> fetchData() async {
    try {
      _noteList = await NoteService.fetchPosts();
      _filteredNoteList = _noteList; // Initialize filtered list with all notes
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void getFilteredNotes(String searchTerm) {
    if (searchTerm.isEmpty) {
      _filteredNoteList = _noteList; // Show all notes if search term is empty
    } else {
      _filteredNoteList = _noteList
          .where((note) =>
              note.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
              note.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners after updating the filtered list
  }

  Future<void> addNote(NoteModel newNote) async {
    try {
      await NoteService.createPost(newNote);
      fetchData(); // Panggil fetchData setelah menambahkan catatan baru
    } catch (e) {
      print('Error adding Note: $e');
    }
  }

  Future<void> deleteNote(String postId) async {
    try {
      await NoteService.deletePost(postId);
      fetchData(); // Panggil fetchData setelah menghapus catatan
    } catch (e) {
      print('Error deleting Note: $e');
    }
  }
}
