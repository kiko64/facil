import 'package:flutter/material.dart';
import 'package:facilapp/pos/dependencies_provider.dart';

import 'package:facilapp/pos/presentation/products/products_presenter.dart';
import 'package:facilapp/pos/presentation/products/products_state.dart';
import 'package:facilapp/pos/presentation/products/widgets/product_item.dart';

class ProductList extends StatefulWidget {

  final ProductsPresenter _productsPresenter;
  final void Function(ProductItemState productItemState) _addProductToCartCallback;

  ProductList(this._addProductToCartCallback)
      : _productsPresenter = getIt<ProductsPresenter>();

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductsState>(                                        // FutureBuilder<List<cto>>
        initialData: null,
        future: widget._productsPresenter.search('Element'),                    //  Buscar.downloadProducto( widget.value, _queryText ),
        builder: (context, snapshot) {                                          //  builder: (context, snapshot) {
          if (snapshot.hasData)                                                 //    if (snapshot.hasData) {
            return renderProductList(context, snapshot.data);                   //      registros = snapshot.data; return CustomListView();
          else                                                                  //    else
            if (snapshot.hasError) {                                            //    if (snapshot.hasError) {
              return Text(snapshot.error.toString());                           //      return Text('${snapshot.error}');
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
        }
    );
  }

  Widget renderProductList(BuildContext context, ProductsState state) {
    return GridView.builder(
      itemCount: state.products.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250.0, childAspectRatio: 0.58),
      itemBuilder: (context, index) {
        final ProductItemState product = state.products[index];

        return ProductItem(product, widget._addProductToCartCallback);
      },
    );
  }
}
