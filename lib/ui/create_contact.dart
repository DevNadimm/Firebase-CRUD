import 'package:firebase_crud/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateContact extends StatelessWidget {
  CreateContact({super.key});

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Contact",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.deepPurple.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Name",
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a contact number";
                          } else if (value.length < 10 || value.length > 12) {
                            return "Contact number must be between 10 and 12 digits";
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Contact number must contain only digits";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.deepPurple.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Contact No.",
                          prefixIcon: const Icon(CupertinoIcons.phone),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RoundedButton(
                        title: 'Save',
                        onTap: () {
                          if (_key.currentState!.validate()) {

                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
