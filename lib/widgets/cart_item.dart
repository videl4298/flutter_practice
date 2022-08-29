import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title, {
    super.key,
  });
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 20,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: ((ctx) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content:
                    const Text('Do you want to delete item from the cart?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: (() {
                      Navigator.of(ctx).pop(false);
                    }),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: (() {
                      Navigator.of(ctx).pop(true);
                    }),
                    child: const Text('Yes'),
                  ),
                ],
              );
            }));
      },
      onDismissed: ((direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      }),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
