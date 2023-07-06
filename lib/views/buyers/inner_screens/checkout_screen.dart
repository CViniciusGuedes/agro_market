import 'package:agro_market/provider/cart_provider.dart';
import 'package:agro_market/views/buyers/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Algo Deu Errado");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Documento Não Existe");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 0,
              title: Text(
                'Resumo do Pedido',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _cartProvider.getCartItem.length,
                itemBuilder: (context, index) {
                  final cartData = _cartProvider.getCartItem.values.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      child: SizedBox(
                        height: 170,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(cartData.imageUrlList[0]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartData.productName.length > 20 ? cartData.productName.substring(0, 20) + '...' : cartData.productName,
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'R\$ ' + cartData.productPrice.toStringAsFixed(2),
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            bottomSheet: Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  EasyLoading.show(status: 'Fazendo Pedido');
                  _cartProvider.getCartItem.forEach((key, item) {
                    final orderId = Uuid().v4();
                    _firestore.collection('orders').doc(orderId).set({
                      'orderId': orderId,
                      'vendorId': item.vendorId,
                      'email': data['email'],
                      'phone': data['phoneNumber'],
                      'address': data['address'],
                      'buyerId': data['buyerId'],
                      'fullName': data['fullName'],
                      'buyerPhoto': data['profileImage'],
                      'productName': item.productName,
                      'productPrice': item.productPrice,
                      'productId': item.productId,
                      'productImage': item.imageUrlList,
                      'quantity': item.productQuantity,
                      'soldQuantity': item.quantity,
                      'orderDate': DateTime.now(),
                    }).whenComplete(() {
                      setState(() {
                        _cartProvider.getCartItem.clear();
                      });

                      EasyLoading.dismiss();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainScreen();
                          },
                        ),
                      );
                    });
                  });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Finalizar Compra',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Center(
          child: LinearProgressIndicator(
            color: Colors.green,
          ),
        );
      },
    );
  }
}
