import 'package:flutter/material.dart';
import 'package:rest_api_flutter/model/note_model.dart';
import 'package:rest_api_flutter/service/note_service.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> _noteList = [];

  List<NoteModel> get noteList => _noteList;

  Future<void> fetchData() async {
    try {
      _noteList = await NoteService.fetchPosts();
      notifyListeners();
    } catch (e) {
      // Handle error, e.g., show an error message
      print('Error fetching data: $e');
    }
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
