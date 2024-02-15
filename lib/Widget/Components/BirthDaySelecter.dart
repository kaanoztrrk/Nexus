// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../Util/Colors.dart';

class BirthdaySelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const BirthdaySelector({super.key, required this.onDateSelected});

  @override
  _BirthdaySelectorState createState() => _BirthdaySelectorState();
}

class _BirthdaySelectorState extends State<BirthdaySelector> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: AppColor().crdColor,
              ),
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                "Selected: ${_formatDate(selectedDate)}",
                style: TextStyle(
                  color: AppColor().white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      widget.onDateSelected(selectedDate);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
