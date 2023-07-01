import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  /*DateTime? selectedDate;

  void showDatePickerDialog() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }*/

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome do Produto',
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Quantidade',
                ),
              ),
              SizedBox(height: 35),
              DropdownButtonFormField(
                hint: Text('Selecione Uma Categoria'),
                items: _categoryList.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {},
              ),
              SizedBox(height: 30),
              TextFormField(
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: 'Descrição do Produto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: showDatePickerDialog,
                  child: Text('Selecionar Data de Validade'),
                ),
              ),
              selectedDate != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Data de Validade: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : Container(),*/
            ],
          ),
        ),
      ),
    );
  }
}
