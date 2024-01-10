import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_flutter/model/note_model.dart';

class NoteService {
  static Future<List<NoteModel>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);

      // Membuat list NoteModel dari data JSON
      List<NoteModel> fetchedData =
          responseData.map((data) => NoteModel.fromJson(data)).toList();

      return fetchedData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<NoteModel> createPost(NoteModel note) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': note.userId,
        'title': note.title,
        'body': note.body,
      }),
    );

    if (response.statusCode == 201) {
      return NoteModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  static Future<void> deletePost(String postId) async {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/${postId}'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
