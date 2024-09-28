import 'package:firebase_crud/ui/firebase_database/contact_list.dart';
import 'package:firebase_crud/ui/firebase_firestore/contact_list_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyContact",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0XFF0060D4),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ContactList(),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0XFF0060D4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/firebase_icon.png",
                            scale: 2.25,
                          ),
                          const Text(
                            "Firebase Database",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ContactListFirestore(),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0XFF0060D4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/firebase_icon.png",
                            scale: 2.25,
                          ),
                          const Text(
                            "Firebase Firestore",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
