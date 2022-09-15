import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/product.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<Products>(ctx, listen: false).fetchAndSetProducts(
      filterByUser: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: (() {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            }),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: (() {
                    return _refreshProducts(context);
                  }),
                  child: Consumer<Products>(
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: ((_, index) {
                              return Column(
                                children: [
                                  UserProductItem(
                                      id: value.items[index].id,
                                      title: value.items[index].title,
                                      imageUrl: value.items[index].imageUrl),
                                  const Divider(),
                                ],
                              );
                            })),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
