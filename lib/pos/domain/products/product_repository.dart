import 'package:facilapp/pos/domain/products/product.dart';

abstract class ProductRepository {
  Future<List<Product>> get();
}
