import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addAssistantData(String term, String information) async {
  CollectionReference assistantCollection =
      FirebaseFirestore.instance.collection('assistant_data');

  await assistantCollection.add({
    'term': term,
    'information': information,
  });
}
