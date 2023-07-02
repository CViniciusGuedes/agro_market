import 'package:agro_market/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                decoration: InputDecoration(
                  labelText: 'Nome do Produto',
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(
                      productPrice: double.parse(value));
                },
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(quantity: int.parse(value));
                },
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
                onChanged: (value) {
                  setState(() {
                    _productProvider.getFormData(category: value);
                  });
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                minLines: 3,
                maxLines: 10,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: 'Descrição do Produto',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
