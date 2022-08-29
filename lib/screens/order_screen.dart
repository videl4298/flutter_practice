import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart';

class OrdersScreens extends StatelessWidget {
  const OrdersScreens({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: ((_, index) {
            return OrderItemWidget(ordersData.orders[index]);
          })),
    );
  }
}
