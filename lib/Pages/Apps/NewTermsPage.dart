import 'package:flutter/material.dart';
import '../../Controller/AddTermState.dart';

class AddTermPage extends StatefulWidget {
  @override
  _AddTermPageState createState() => _AddTermPageState();
}

class _AddTermPageState extends State<AddTermPage> {
  TextEditingController termController = TextEditingController();
  TextEditingController informationController = TextEditingController();
  Assistant_Term_Data termData =
      Assistant_Term_Data(); // Assistant_Term_Data sınıfını oluşturun

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Term Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: termController,
              decoration: InputDecoration(labelText: 'Enter Term'),
            ),
            TextField(
              controller: informationController,
              decoration: InputDecoration(labelText: 'Enter Information'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Assistant_Term_Data sınıfını kullanarak terimi Firestore'a ekleyin
                _addTermToFirestore();
              },
              child: Text('Add Term'),
            ),
          ],
        ),
      ),
    );
  }

  // Assistant_Term_Data sınıfını kullanarak terimi Firestore'a ekleyen fonksiyon
  void _addTermToFirestore() {
    String term = termController.text.toLowerCase();
    String information = informationController.text;

    termData.addTerm(term, information);

    // Ekledikten sonra text alanlarını temizleyin
    termController.clear();
    informationController.clear();
  }
}
