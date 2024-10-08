import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateContactFirestore extends StatefulWidget {
  const CreateContactFirestore({super.key});

  @override
  _CreateContactFirestoreState createState() => _CreateContactFirestoreState();
}

class _CreateContactFirestoreState extends State<CreateContactFirestore> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final CollectionReference databaseCollection =
  FirebaseFirestore.instance.collection('Contact');

  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
        backgroundColor: const Color(0XFF0060D4),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: const Color(0XFF0060D4).withOpacity(0.1),
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
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a contact number";
                        } else if (value.length < 9 || value.length > 12) {
                          return "Contact number must be between 9 and 12 digits";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: const Color(0XFF0060D4).withOpacity(0.1),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Contact No.",
                        prefixIcon: const Icon(CupertinoIcons.phone),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RoundedButton(
                      title: 'Save',
                      isLoading: _isSaving,
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            _isSaving = true;
                          });

                          FocusScope.of(context).unfocus();

                          try {

                            /// 1 Approach
                            // DocumentReference newContactRef = databaseCollection.doc();
                            // await newContactRef.set({
                            //   'name': _nameController.text.trim(),
                            //   'contact': _phoneController.text.trim(),
                            // });

                            /// Another Approach
                            await databaseCollection.add({
                              'name': _nameController.text.trim(),
                              'contact': _phoneController.text.trim(),
                            });

                            Fluttertoast.showToast(
                              msg: "Contact saved successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );

                            _key.currentState!.reset();
                            _nameController.clear();
                            _phoneController.clear();

                            Navigator.pop(context);
                          } catch (error) {
                            Fluttertoast.showToast(
                              msg: "Failed to save contact: $error",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          } finally {
                            setState(() {
                              _isSaving = false;
                            });
                          }
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
    );
  }
}
