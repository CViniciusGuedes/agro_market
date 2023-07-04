import 'package:agro_market/vendor/models/cart_attributes.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttr> _cartItems = {};

  Map<String, CartAttr> get getCartItem {
    return _cartItems;
  }

  void addProductToCart(
    String productName,
    String productId,
    List imageUrlList,
    int quantity,
    double productPrice,
    String vendorId,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCart) => CartAttr(
          productName: existingCart.productName,
          productId: existingCart.productId,
          imageUrlList: existingCart.imageUrlList,
          quantity: existingCart.quantity + 1,
          productPrice: existingCart.productPrice,
          vendorId: vendorId,
        ),
      );
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartAttr(
          productName: productName,
          productId: productId,
          imageUrlList: imageUrlList,
          quantity: quantity,
          productPrice: productPrice,
          vendorId: vendorId,
        ),
      );
      notifyListeners();
    }
  }
}
