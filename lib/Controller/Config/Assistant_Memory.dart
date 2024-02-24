import 'dart:collection';

class ShortTermMemoryService {
  List<String> _lists = [];
  Map<String, String> _dictionary = {};
  Queue<String> _queue = Queue();

  // Yeni bir liste oluştur
  void createList(String listName) {
    _lists.add(listName);
  }

  // Yeni bir sözlük oluştur
  void createDictionary(String key, String value) {
    _dictionary[key] = value;
  }

  // Yeni bir kuyruk oluştur
  void enqueue(String item) {
    _queue.add(item);
  }

  // Listeleri getir
  List<String> getLists() {
    return _lists;
  }

  // Sözlüğü getir
  Map<String, String> getDictionary() {
    return _dictionary;
  }

  // Kuyruğu getir
  List<String> getQueue() {
    return _queue.toList();
  }

  void printLists() {
    print("Mevcut Listeler:");
    _lists.forEach((list) {
      print("- $list");
    });
  }
}
