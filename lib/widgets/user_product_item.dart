import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: (() {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: id,
              );
            }),
            icon: const Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: (() async {
              try {
                await Provider.of<Products>(
                  context,
                  listen: false,
                ).deleteProduct(id);
              } catch (error) {
                scaffoldMessenger.showSnackBar(const SnackBar(
                  content: Text('Deleting failed!'),
                ));
              }
            }),
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
