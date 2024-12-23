// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  String selectedGender = "Male";
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveUserProfileToFirebase(String firstName, String lastName,
      String gender, DateTime birthDate) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'birth_date': birthDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            DropdownButton<String>(
              value: selectedGender,
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value!;
                });
              },
              items: ['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            Row(
              children: [
                Text("Birth Date: ${selectedDate.toLocal()}".split(' ')[0]),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;

                await saveUserProfileToFirebase(
                    firstName, lastName, selectedGender, selectedDate);

                Navigator.pop(context); // Ana sayfaya geri dön
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      ),
    );
  }
}
