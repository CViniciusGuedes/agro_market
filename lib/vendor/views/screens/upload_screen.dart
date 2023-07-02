import 'package:agro_market/provider/product_provider.dart';
import 'package:agro_market/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:agro_market/vendor/views/screens/upload_tab_screens/images_screen.dart';
import 'package:agro_market/vendor/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                'Geral',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Entrega',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Imagens',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          GeneralScreen(),
          ShippingScreen(),
          ImagesScreen(),
        ]),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              print(_productProvider.productData['productName']);
              print(_productProvider.productData['productPrice']);
              print(_productProvider.productData['quantity']);
              print(_productProvider.productData['category']);
              print(_productProvider.productData['description']);
              print(_productProvider.productData['imageUrlList']);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Salvar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
