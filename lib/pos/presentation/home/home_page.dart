import 'package:flutter/material.dart';
import 'package:facilapp/pos/dependencies_provider.dart';
import 'package:facilapp/pos/presentation/cart/cart_presenter.dart';
import 'package:facilapp/pos/presentation/cart/cart_state.dart';
import 'package:facilapp/pos/presentation/cart/widgets/cart_drawer.dart';
import 'package:facilapp/pos/presentation/home/my_app_bar.dart';
import 'package:facilapp/pos/presentation/products/products_state.dart';
import 'package:facilapp/pos/presentation/products/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  final CartPresenter _cartPresenter;

  HomePage() : _cartPresenter = getIt<CartPresenter>();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CartState _cartState;

  @override
  void initState() {
    super.initState();
    _cartState = CartState.createEmpty();

    widget._cartPresenter.init(updateState);
  }

  void updateState(CartState cartState) {
    setState(() {
      _cartState = cartState;
    });
  }

  void _addProductToCart(ProductItemState productItemState) {
    widget._cartPresenter.addProductToCartCart(productItemState);
  }

  void _removeItemFromCart(CartItemState cartItemState) {
    widget._cartPresenter.removeCartItemOfCart(cartItemState);
  }

  void _editQuantityOfCartItem(CartItemState cartItemState, int quantity) {
    widget._cartPresenter.editQuantityOfCartItem(cartItemState, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MyAppBar(_cartState.totalItems),

      body: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ProductList(_addProductToCart),
      ),
      endDrawer:

      CartDrawer(_cartState, _editQuantityOfCartItem, _removeItemFromCart),

    );
  }
}
