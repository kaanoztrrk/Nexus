class ToDoModel {
  int? id;
  String title;
  String creationDate;

  ToDoModel({
    this.id,
    required this.title,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'creationDate': creationDate.toString(), // creationDate'i haritaya ekle
    };
  }
}
