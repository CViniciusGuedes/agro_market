import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? address;
  //final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _fullNameController.text = widget.userData['fullName'];
      _emailController.text = widget.userData['email'];
      _phoneController.text = widget.userData['phoneNumber'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.photo),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _fullNameController,
                    decoration: InputDecoration(
                      labelText: 'Nome Completo',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Número de Celular',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      address = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Insira Seu Endereço',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(14.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: 'Atualizando Dados');
            await _firestore.collection('buyers').doc(FirebaseAuth.instance.currentUser!.uid).update({
              'fullName': _fullNameController.text,
              'email': _emailController.text,
              'phoneNumber': _phoneController.text,
              'address': address,
            }).whenComplete(() {
              EasyLoading.dismiss();
              Navigator.pop(context);
            });
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              'Atualizar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
          ),
        ),
      ),
    );
  }
}
