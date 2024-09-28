import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/ui/firebase_firestore/create_contact_firestore.dart';
import 'package:firebase_crud/widgets/logout_dialog.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactListFirestore extends StatefulWidget {
  const ContactListFirestore({super.key});

  @override
  State<ContactListFirestore> createState() => _ContactListFirestoreState();
}

class _ContactListFirestoreState extends State<ContactListFirestore> {
  final ref = FirebaseFirestore.instance.collection('Contact').snapshots();
  final TextEditingController _nameUpdateController = TextEditingController();
  final TextEditingController _contactUpdateController =
      TextEditingController();

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
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: ref,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              else if(snapshot.hasError){
                return const Text('An Error Occurred');
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    final name = snapshot.data!.docs[index]['name'].toString();
                    final contact = snapshot.data!.docs[index]['contact'].toString();
                    final id = snapshot.data!.docs[index]['id'].toString();

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
                      // trailing: PopupMenuButton(
                      //   icon: const Icon(Icons.more_vert),
                      //   itemBuilder: (context) => [
                      //     PopupMenuItem(
                      //       value: 1,
                      //       onTap: () {
                      //         showMyDialog(name, contact, id);
                      //       },
                      //       child: const ListTile(
                      //         leading: Icon(Icons.edit),
                      //         title: Text("Edit"),
                      //       ),
                      //     ),
                      //     PopupMenuItem(
                      //       value: 2,
                      //       onTap: () {
                      //         ref.child(id).remove();
                      //       },
                      //       child: const ListTile(
                      //         leading: Icon(Icons.delete),
                      //         title: Text("Delete"),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// Future<void> showMyDialog(String name, String contact, String id) async {
//   _nameUpdateController.text = name;
//   _contactUpdateController.text = contact;
//
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text(
//           'Update',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameUpdateController,
//               decoration: InputDecoration(
//                 label: const Text('Name'),
//                 labelStyle: const TextStyle(fontWeight: FontWeight.w500),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(width: 2, color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(width: 2, color: Colors.grey),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             TextField(
//               keyboardType: TextInputType.number,
//               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//               controller: _contactUpdateController,
//               decoration: InputDecoration(
//                 label: const Text('Contact'),
//                 labelStyle: const TextStyle(fontWeight: FontWeight.w500),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(width: 2, color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(width: 2, color: Colors.grey),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.grey[300],
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text(
//               "Cancel",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               ref.child(id).update(
//                 {
//                   'name': _nameUpdateController.text.trim(),
//                   'contact': _contactUpdateController.text.trim(),
//                 },
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0XFF0060D4),
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text(
//               "Save",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
}
