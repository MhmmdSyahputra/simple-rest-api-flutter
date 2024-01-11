import 'dart:ffi';

class NoteModel {
  final String id;
  final String title;
  final int price; // Ubah tipe data price ke int
  final String desc;
  final String category;
  final String image;
  // final String rating;

  NoteModel({
    required this.id,
    required this.title,
    required this.price,
    required this.desc,
    required this.category,
    required this.image,
    // required this.rating,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      price: json['price'].toInt(), // Konversi ke int
      desc: json['desc'].toString(),
      category: json['category'].toString(),
      image: json['image'].toString(),
      // rating: json['rating'] as String,
    );
  }
}
