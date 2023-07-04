import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String productName;
  final String productId;
  final List imageUrlList;
  final int quantity;
  final double productPrice;
  final String vendorId;

  CartAttr(
      {required this.productName,
      required this.productId,
      required this.imageUrlList,
      required this.quantity,
      required this.productPrice,
      required this.vendorId});
}
