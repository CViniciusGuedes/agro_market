//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VendorOrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream =
        FirebaseFirestore.instance.collection('orders').where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Minhas Vendas',
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
              return Slidable(
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 14,
                        child: document['accepted'] == true ? Icon(Icons.delivery_dining) : Icon(Icons.access_time),
                      ),
                      title: document['accepted'] == true
                          ? Text(
                              'Entrega Concluída',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                              ),
                            )
                          : Text(
                              'Entrega Pendente',
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
                      //subtitle: Text('Ver Detalhes Da Compra'),
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Image.network(
                              document['productImage'][0],
                            ),
                          ),
                          title: Text(document['productName']),
                          subtitle: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
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
                ),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore.collection('orders').doc(document['orderId']).update({
                          'accepted': false,
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      //icon: Icons.block,
                      icon: Icons.thumb_down,
                      label: 'Pendente',
                    ),
                    SlidableAction(
                      onPressed: (context) async {
                        await _firestore.collection('orders').doc(document['orderId']).update({
                          'accepted': true,
                        });
                      },
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.thumb_up,
                      label: 'Entregue',
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
