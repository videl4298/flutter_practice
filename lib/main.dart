import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
import 'screens/user_products_screens.dart';
import 'screens/edit_product_screen.dart';

import 'providers/products.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => Products()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Cart()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Orders()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.deepOrange,
              ),
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreens.routeName: ((ctx) => const OrdersScreens()),
          UserProductsScreen.routeName: ((ctx) => const UserProductsScreen()),
          EditProductScreen.routeName: ((ctx) => const EditProductScreen()),
        },
      ),
    );
  }
}
