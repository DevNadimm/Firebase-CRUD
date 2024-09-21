import 'package:firebase_crud/ui/create_contact.dart';
import 'package:firebase_crud/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateContact(),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_box),
      ),
      body: const Center(
        child: Text('Home Screen Content'),
      ),
    );
  }
}
