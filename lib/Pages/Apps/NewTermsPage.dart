// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../Controller/AddTermState.dart';

class AddTermPage extends StatefulWidget {
  const AddTermPage({super.key});

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
        title: const Text('Add Term Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: termController,
              decoration: const InputDecoration(labelText: 'Enter Term'),
            ),
            TextField(
              controller: informationController,
              decoration: const InputDecoration(labelText: 'Enter Information'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Assistant_Term_Data sınıfını kullanarak terimi Firestore'a ekleyin
                _addTermToFirestore();
              },
              child: const Text('Add Term'),
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
