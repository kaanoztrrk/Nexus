class NoteModel {
  int? id;
  String title;
  String body;
  String creationDate;

  NoteModel({
    this.id,
    required this.title,
    required this.body,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'creationDate': creationDate.toString(), // creationDate'i haritaya ekle
    };
  }
}
