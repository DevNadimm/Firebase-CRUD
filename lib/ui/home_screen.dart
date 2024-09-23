import 'package:firebase_crud/ui/create_contact.dart';
import 'package:firebase_crud/widgets/logout_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('Contact');
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameUpdateController = TextEditingController();
  final TextEditingController _contactUpdateController = TextEditingController();

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
                            showMyDialog(name, contact, id);
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

  Future<void> showMyDialog(String name, String contact, String id) async {
    _nameUpdateController.text = name;
    _contactUpdateController.text = contact;

    return showDialog(
      context: context,
      builder: (context) {
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
                Navigator.of(context).pop();
                ref.child(id).update(
                  {
                    'name': _nameUpdateController.text.trim(),
                    'contact': _contactUpdateController.text.trim(),
                  },
                );
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
      },
    );
  }
}
