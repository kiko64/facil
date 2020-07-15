import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/pos/presentation/cart/cart_state.dart';
import 'package:facilapp/pos/presentation/cart/widgets/cart_content.dart';

class CartDrawer extends StatelessWidget {
  final CartState _cartState;
  final void Function(CartItemState cartItemState, int quantity)
      _editQuantityOfCartItemCallback;
  final void Function(CartItemState cartItemState) _removeItemFromCartCallback;

  const CartDrawer(this._cartState, this._editQuantityOfCartItemCallback,
      this._removeItemFromCartCallback);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 96,
            child: DrawerHeader(
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_cart),
                      Text(
                        ' Pedido',
                        style: Theme.of(context).textTheme.title,
                      )
                    ],
                  ),
                  onTap: () {},
                )),
          ),
          Expanded(
              child: CartContent(_cartState, _editQuantityOfCartItemCallback,
                  _removeItemFromCartCallback))
        ],
      ),
    );
  }
}
