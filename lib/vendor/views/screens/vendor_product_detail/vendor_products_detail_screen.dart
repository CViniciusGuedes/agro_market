import 'package:agro_market/utils/show_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() => _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _productPriceController.text = widget.productData['productPrice'].toStringAsFixed(2);
      _quantityController.text = widget.productData['quantity'].toString();
      _descriptionController.text = widget.productData['description'];
      _categoryController.text = widget.productData['category'];
    });
    super.initState();
  }

  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(
          widget.productData['productName'],
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  productPrice = double.parse(value);
                },
                controller: _productPriceController,
                decoration: InputDecoration(labelText: 'Preço'),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  productQuantity = int.parse(value);
                },
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 800,
                minLines: 2,
                maxLines: 6,
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: false,
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Categoria'),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (productPrice != null && productQuantity != null) {
              await _firestore.collection('products').doc(widget.productData['productId']).update({
                'productName': _productNameController.text,
                'productPrice': productPrice,
                'quantity': productQuantity,
                'description': _descriptionController.text,
                'category': _categoryController.text,
              });
            } else {
              showSnack(context, 'Atualize a Quantidade e o Preço');
            }
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
                'Atualizar Informações',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
