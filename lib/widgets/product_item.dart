import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/cart.dart';
import 'package:flutter_application_1/providers/product.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  // const ProductItem(this.id, this.title, this.imageUrl, {super.key});

  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
              builder: ((ctx, value, child) => IconButton(
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: (() {
                      product.toggleFavoriteStatus(
                          authData.token as String, authData.userId as String);
                    }),
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ))),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            onPressed: (() {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text("Added item to cart"),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: (() {
                    cart.removeSingleItem(product.id);
                  }),
                ),
              ));
              // Scaffold.of(context).hideCurrentSnackBar();
              // Scaffold.of(context).showSnackBar(SnackBar(
              //   content: const Text('Added item to cart'),
              //   duration: const Duration(
              //     seconds: 2,
              //   ),
              //   action: SnackBarAction(
              //     label: 'Undo',
              //     onPressed: (() {
              //       cart.removeSingleItem(product.id);
              //     }),
              //   ),
              // ));
            }),
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
