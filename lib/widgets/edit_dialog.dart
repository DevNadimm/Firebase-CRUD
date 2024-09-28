import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditDialog extends StatefulWidget {
  const EditDialog(
      {super.key, required this.name, required this.contact, required this.id});

  final String name;
  final String contact;
  final String id;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  var _nameUpdateController = TextEditingController();
  var _contactUpdateController = TextEditingController();

  @override
  void initState() {
    _nameUpdateController = TextEditingController(text: widget.name);
    _contactUpdateController = TextEditingController(text: widget.contact);
    super.initState();
  }

  @override
  void dispose() {
    _nameUpdateController.dispose();
    _contactUpdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Update',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameUpdateController,
            decoration: InputDecoration(
              label: const Text('Name'),
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 2, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 2, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: _contactUpdateController,
            decoration: InputDecoration(
              label: const Text('Contact'),
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 2, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 2, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Contact')
                .doc(widget.id)
                .update(
              {
                'name': _nameUpdateController.text.trim(),
                'contact': _contactUpdateController.text.trim(),
              },
            );
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0XFF0060D4),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

void showEditDialog(
    BuildContext context, String name, String contact, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditDialog(
        name: name,
        contact: contact,
        id: id,
      );
    },
  );
}
