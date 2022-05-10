import 'package:flutter/material.dart';
import 'package:flutter_contact_list/components/contact_row.dart';
import 'package:flutter_contact_list/data/contact_data.dart';
import 'package:flutter_contact_list/models/contact.dart';
import 'package:flutter_contact_list/pages/contact_detail_page.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final _contacts = <Contact>[...contactData];
  int _selectedContactIndex = -1;

  void _setSelectedContact({required Contact contact, required index}) {
    setState(() {
      _selectedContactIndex = index;
    });
  }

  void _handleSave(Contact contact) {
    if (_selectedContactIndex >= 0) {
      setState(() {
        _contacts[_selectedContactIndex] = contact;
      });
    } else {
      setState(() {
        _contacts.add(contact);
      });
    }
  }

  void _addNewContact() {
    _goToDetail(Contact(name: "", phone: "", email: "", address: ""), -1);
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _goToDetail(Contact contact, int index) {
    _setSelectedContact(contact: contact, index: index);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ContactDetail(
          contact: contact,
          onSave: _handleSave,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lista de contactos"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (BuildContext context, int index) => ContactRow(
            contact: _contacts[index],
            onTap: _goToDetail,
            index: index,
            onDelete: _deleteContact,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewContact,
        tooltip: 'Agregar nuevo contacto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
