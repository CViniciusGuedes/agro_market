import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream =
        FirebaseFirestore.instance.collection('orders').where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Minhas Compras',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Algo Deu Errado'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 14,
                      child: document['accepted'] == true ? Icon(Icons.delivery_dining) : Icon(Icons.access_time),
                    ),
                    title: document['accepted'] == true
                        ? Text(
                            'Aceito',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                            ),
                          )
                        : Text(
                            'Não Aceito',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                    trailing: Text(
                      'Valor: ' + document['productPrice'].toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      formatedDate(
                        document['orderDate'].toDate(),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Detalhes Da Compra',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            document['productImage'][0],
                          ),
                        ),
                        title: Text(document['productName']),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ('Quantidade: '),
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  document['soldQuantity'].toString(),
                                ),
                              ],
                            ),
                            ListTile(
                              title: Text(
                                'Detalhes do Comprador',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nome: ' + document['fullName']),
                                  SizedBox(height: 5),
                                  Text('Email: ' + document['email']),
                                  SizedBox(height: 5),
                                  Text('Endereço: ' + document['address']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
