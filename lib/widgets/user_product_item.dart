import 'package:flutter/material.dart';

import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
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
              // Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: ,);
            }),
            icon: const Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: (() {}),
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ],
      ),
    );
  }
}
