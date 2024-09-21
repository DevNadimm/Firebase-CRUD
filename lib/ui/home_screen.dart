import 'package:firebase_crud/ui/create_contact.dart';
import 'package:firebase_crud/widgets/logout_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('Contact');
  final TextEditingController _searchController = TextEditingController();

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
              builder: (_) => const CreateContact(),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_box),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _searchController,
              onChanged: (String value) {
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: Colors.deepPurple.withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Search contact",
                prefixIcon: const Icon(CupertinoIcons.search),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ),
              itemBuilder: (context, snapshot, animation, index) {
                String name = snapshot.child('name').value.toString();
                String contact = snapshot.child('contact').value.toString();



                return ListTile(
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    contact,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
