import 'package:firebase_crud/ui/firebase_database/create_contact.dart';
import 'package:firebase_crud/widgets/edit_dialog.dart';
import 'package:firebase_crud/widgets/logout_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('Contact');
  final TextEditingController _searchController = TextEditingController();

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
              builder: (_) => const CreateContact(),
            ),
          );
        },
        backgroundColor: const Color(0XFF0060D4),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_box),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              style: const TextStyle(fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                fillColor: const Color(0XFF0060D4).withOpacity(0.1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Search contact",
                hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                prefixIcon: const Icon(CupertinoIcons.search),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild: const Center(
                child: CircularProgressIndicator(
                  color: Color(0XFF0060D4),
                ),
              ),
              itemBuilder: (context, snapshot, animation, index) {
                String name = snapshot.child('name').value.toString();
                String contact = snapshot.child('contact').value.toString();
                String id = snapshot.child('id').value.toString();

                if (_searchController.text.isEmpty ||
                    name
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase())) {
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
                            ref.child(id).remove();
                          },
                          child: const ListTile(
                            leading: Icon(Icons.delete),
                            title: Text("Delete"),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
