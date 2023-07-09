import 'package:agro_market/views/buyers/product_detail/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchValue = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextFormField(
          onChanged: (value) {
            setState(() {
              _searchValue = value;
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Pesquisar Por Produtos',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: _searchValue == ''
          ? Center(
              child: Text(
                'Pesquise Por Um Produto',
                style: TextStyle(fontSize: 20),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                final searchData = snapshot.data!.docs.where((element) {
                  return element['productName'].toLowerCase().contains(_searchValue.toLowerCase());
                });

                return SingleChildScrollView(
                  child: Column(
                    children: searchData.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailScreen(productData: e);
                              },
                            ),
                          );
                        },
                        child: Card(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  e['imageUrlList'][0],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Text(
                                      e['productName'].length > 18 ? '${e['productName'].substring(0, 18)}...' : e['productName'],
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'R\$ ' + e['productPrice'].toStringAsFixed(2),
                                      style: TextStyle(fontSize: 18, color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
