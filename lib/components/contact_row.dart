import 'package:flutter/material.dart';
import 'package:flutter_contact_list/models/contact.dart';

class ContactRow extends StatelessWidget {
  const ContactRow(
      {Key? key,
      required this.contact,
      required this.onTap,
      required this.index,
      required this.onDelete})
      : super(key: key);

  final Contact contact;
  final Function onTap;
  final Function onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const CircleAvatar(
            radius: 25,
            child: Icon(
              Icons.person,
              size: 25,
            )),
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.phone,
              style: const TextStyle(fontSize: 16),
            ),
            Text(contact.email),
            Text(contact.address),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () => onDelete(index),
        ),
        onTap: () => onTap(contact, index));
  }
}
