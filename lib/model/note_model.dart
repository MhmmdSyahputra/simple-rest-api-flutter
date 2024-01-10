class NoteModel {
  final String userId;
  final String id;
  final String title;
  final String body;

  NoteModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      userId: json['userId'].toString(),
      id: json['id'].toString(),
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
