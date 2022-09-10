import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart';

class OrdersScreens extends StatefulWidget {
  const OrdersScreens({super.key});

  static const routeName = '/orders';

  @override
  State<OrdersScreens> createState() => _OrdersScreensState();
}

class _OrdersScreensState extends State<OrdersScreens> {
  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              // Do error handling stuff
              return const Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(builder: ((ctx, value, child) {
                return ListView.builder(
                    itemCount: value.orders.length,
                    itemBuilder: ((_, index) {
                      return OrderItemWidget(value.orders[index]);
                    }));
              }));
            }
          }
        },
      ),
    );
  }
}
