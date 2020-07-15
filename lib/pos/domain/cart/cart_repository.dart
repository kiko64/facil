import 'package:facilapp/pos/domain/cart/Cart.dart';

abstract class CartRepository {
  Future<Cart> get();

  Future<bool> save(Cart cart);
}
