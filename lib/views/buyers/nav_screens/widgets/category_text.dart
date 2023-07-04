import 'package:agro_market/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream = FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categorias',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Algo Deu Errado');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Carregando Categorias");
              }

              return Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final categoryData = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ActionChip(
                                backgroundColor: Color.fromARGB(255, 201, 153, 135),
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory = categoryData['categoryName'];
                                  });
                                  print(_selectedCategory);
                                },
                                label: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      categoryData['categoryName'],
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    /*IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right))*/
                  ],
                ),
              );
            },
          ),
          if (_selectedCategory != null) HomeProductWidget(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
