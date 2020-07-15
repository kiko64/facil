import 'dart:convert';

import 'package:facilapp/pos/domain/cart/Cart.dart';
import 'package:facilapp/pos/domain/cart/CartItem.dart';
import 'package:facilapp/pos/domain/cart/cart_repository.dart';

const jsonCartOld = '''[
  {
    "id": "1",
    "image":
    "https://m.media-amazon.com/images/I/81oKhu2bsgL._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Element Blazin LS tee Shirt, Hombre",
    "price": 19.95,
    "quantity": 3
  },
  {
    "id": "2",
    "image":
    "https://m.media-amazon.com/images/I/81HnHYik58L._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Element Vertical SS tee Shirt, Hombre",
    "price": 21.95,
    "quantity": 1
  }
  ]''';

const jsonCart = '''[
  {
    "id": "1001",
    "image":
    "https://ocobosoft.000webhostapp.com/imagen/1001.png",
    "title": "Mango",
    "price": 3000.00,
    "quantity": 3
  }
  ]''';

class CartInMemoryRepository implements CartRepository {
  Cart cart = Cart.createEmpty();

  CartInMemoryRepository() {
    cart = _parse(jsonDecode(jsonCart));
  }

  @override
  Future<Cart> get() async {
    return Future.delayed(const Duration(milliseconds: 100), () => cart);
  }

  @override
  Future<bool> save(Cart cart) async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      this.cart = cart;
      return true;
    });
  }

  Cart _parse(List<dynamic> json) {
    return Cart(json.map((jsonItem) => CartItem(
        jsonItem['id'],
        jsonItem['image'],
        jsonItem['title'],
        jsonItem['price'],
        jsonItem['quantity'])).toList());
  }
}
