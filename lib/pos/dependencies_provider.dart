import 'package:get_it/get_it.dart';
import 'package:facilapp/pos/data/cart/cart_in_memory_repository.dart';
import 'package:facilapp/pos/data/products/product_in_memory_repository.dart';
import 'package:facilapp/pos/domain/cart/cart_repository.dart';
import 'package:facilapp/pos/domain/cart/usecases/add_product_to_cart_use_case.dart';
import 'package:facilapp/pos/domain/cart/usecases/edit_quantity_of_cart_item_use_case.dart';
import 'package:facilapp/pos/domain/cart/usecases/get_cart_use_case.dart';
import 'package:facilapp/pos/domain/cart/usecases/remove_item_to_from_use_case.dart';
import 'package:facilapp/pos/domain/products/get_products_use_case.dart';
import 'package:facilapp/pos/domain/products/product_repository.dart';
import 'package:facilapp/pos/presentation/cart/cart_presenter.dart';
import 'package:facilapp/pos/presentation/products/products_presenter.dart';

final getIt = GetIt.instance;

void init() {
  registerProductDependencies();
  registerCartDependencies();
}

void registerProductDependencies() {
  getIt.registerFactory(() => ProductsPresenter(getIt()));

  getIt.registerLazySingleton(() => GetProductsUseCase(getIt()));

  getIt.registerLazySingleton<ProductRepository>(() => ProductInMemoryRepository());
}

void registerCartDependencies() {
  getIt.registerFactory(() => CartPresenter(getIt(),getIt(),getIt(),getIt(),getIt()));

  getIt.registerLazySingleton(() => GetCartUseCase(getIt()));
  getIt.registerLazySingleton(() => AddProductToCartUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveItemFromCartUseCase(getIt()));
  getIt.registerLazySingleton(() => EditQuantityOfCartItemUseCase(getIt()));

  getIt.registerLazySingleton<CartRepository>(() => CartInMemoryRepository());
}
