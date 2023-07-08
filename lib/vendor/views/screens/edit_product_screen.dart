import 'package:agro_market/vendor/views/screens/edit_products_tabs/published_tab.dart';
import 'package:agro_market/vendor/views/screens/edit_products_tabs/unpublished_tab.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text(
            'Gerenciar Produtos',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Publicados',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: Text(
                  'Não Publicados',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTab(),
            UnpublishedTab(),
          ],
        ),
      ),
    );
  }
}
