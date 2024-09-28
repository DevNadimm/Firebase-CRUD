import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/ui/firebase_firestore/create_contact_firestore.dart';
import 'package:firebase_crud/widgets/edit_dialog.dart';
import 'package:firebase_crud/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';

class ContactListFirestore extends StatefulWidget {
  const ContactListFirestore({super.key});

  @override
  State<ContactListFirestore> createState() => _ContactListFirestoreState();
}

class _ContactListFirestoreState extends State<ContactListFirestore> {
  final ref = FirebaseFirestore.instance.collection('Contact').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact List",
          style: TextStyle(
            fontWeight: FontWeight.w600,
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
        backgroundColor: const Color(0XFF0060D4),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreateContactFirestore(),
            ),
          );
        },
        backgroundColor: const Color(0XFF0060D4),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_box),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ref,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An Error Occurred'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No contacts available.'));
          }

          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                final name = doc['name'].toString();
                final contact = doc['contact'].toString();
                final id = doc.id;

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
                    backgroundColor: const Color(0XFF0060D4),
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        onTap: () {
                          showEditDialog(context, name, contact, id);
                        },
                        child: const ListTile(
                          leading: Icon(Icons.edit),
                          title: Text("Edit"),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('Contact')
                              .doc(id)
                              .delete();
                        },
                        child: const ListTile(
                          leading: Icon(Icons.delete),
                          title: Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
