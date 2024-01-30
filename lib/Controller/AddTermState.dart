import 'package:cloud_firestore/cloud_firestore.dart';

class Assistant_Term_Data {
  // Firestore referansını al
  final CollectionReference _termsCollection =
      FirebaseFirestore.instance.collection('assistant_data');

  // Terimi Firestore'a ekleyen fonksiyon
  Future<void> addTerm(String term, String information) async {
    // Terimi Firestore'a ekleyin
    await _termsCollection.doc(term).set({
      'information': information,
    });

    // Terimin büyük küçük harf varyantlarını oluşturup Firestore'a ekleyin
    String termLower = term.toLowerCase();
    String termUpper = term.toUpperCase();
    String termCapitalized =
        term[0].toUpperCase() + term.substring(1).toLowerCase();

    await _termsCollection.doc(term).collection('variants').doc(termLower).set({
      'information': information,
    });

    await _termsCollection.doc(term).collection('variants').doc(termUpper).set({
      'information': information,
    });

    await _termsCollection
        .doc(term)
        .collection('variants')
        .doc(termCapitalized)
        .set({
      'information': information,
    });
  }
}
