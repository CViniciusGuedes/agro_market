import 'package:agro_market/provider/cart_provider.dart';
import 'package:agro_market/views/buyers/inner_screens/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'Carrinho De Compras',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(CupertinoIcons.delete_solid),
          ),
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData = _cartProvider.getCartItem.values.toList()[index];
                return Card(
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
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 125,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade700,
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: cartData.quantity == 1
                                              ? null
                                              : () {
                                                  _cartProvider.decrement(cartData);
                                                },
                                          icon: Icon(
                                            CupertinoIcons.minus,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          cartData.quantity.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: cartData.productQuantity == cartData.quantity
                                                ? null
                                                : () {
                                                    _cartProvider.inscreament(cartData);
                                                  },
                                            icon: Icon(
                                              CupertinoIcons.plus,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _cartProvider.removeItem(cartData.productId);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Seu Carrinho de Compras Está Vazio',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Continuar Comprando',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CheckOutScreen();
                      },
                    ),
                  );
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _cartProvider.totalPrice == 0.00 ? Colors.grey : Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              'R\$ ' + _cartProvider.totalPrice.toStringAsFixed(2) + ' - ' + 'Checkout',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
            )),
          ),
        ),
      ),
    );
  }
}
