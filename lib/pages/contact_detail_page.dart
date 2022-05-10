import 'package:flutter/material.dart';
import 'package:flutter_contact_list/models/contact.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key, required this.contact, required this.onSave})
      : super(key: key);

  final Contact contact;
  final Function onSave;

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  late String? _name = widget.contact.name;
  late String? _email = widget.contact.email;
  late String? _phone = widget.contact.phone;
  late String? _address = widget.contact.address;

  final _formKey = GlobalKey<FormState>();

  Widget _buildName() => TextFormField(
        controller: TextEditingController(text: _name),
        decoration: const InputDecoration(labelText: "Nombre"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Nombre es requerido';
          }
          return null;
        },
        onSaved: (value) => {_name = value},
      );

  Widget _buildEmail() => TextFormField(
        controller: TextEditingController(text: _email),
        decoration: const InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email es requerido';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Correo invalido';
          }

          return null;
        },
        onSaved: (value) {
          _email = value;
        },
      );

  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: TextEditingController(text: _phone),
      decoration: const InputDecoration(labelText: 'Telefono'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Telefono es requerido';
        }

        return null;
      },
      onSaved: (value) {
        _phone = value;
      },
    );
  }

  Widget _buildAddress() => TextFormField(
        controller: TextEditingController(text: _address),
        decoration: const InputDecoration(labelText: "Dirección"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Dirección es requerida';
          }
          return null;
        },
        onSaved: (value) => {_address = value},
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detalle de contacto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                      radius: 75,
                      child: Icon(
                        Icons.person,
                        size: 85,
                      )),
                  _buildName(),
                  _buildEmail(),
                  _buildPhoneNumber(),
                  _buildAddress(),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    child: const Text(
                      "GUARDAR",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => {
                      if (_formKey.currentState!.validate())
                        {
                          _formKey.currentState!.save(),
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Operación exitosa!'),
                                backgroundColor: Colors.indigoAccent),
                          ),
                          widget.onSave(Contact(
                              name: _name ?? "",
                              phone: _phone ?? "",
                              email: _email ?? "",
                              address: _address ?? "")),
                          Navigator.pop(context),
                        }
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
