import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String productName;
  final String productId;
  final List imageUrlList;
  int quantity;
  int productQuantity;
  final double productPrice;
  final String vendorId;

  CartAttr(
      {required this.productName,
      required this.productId,
      required this.imageUrlList,
      required this.quantity,
      required this.productQuantity,
      required this.productPrice,
      required this.vendorId});

  void increase() {
    quantity++;
  }

  void decrease() {
    quantity--;
  }
}
