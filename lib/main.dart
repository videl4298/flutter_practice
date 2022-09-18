import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'screens/products_overview_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
import 'screens/user_products_screens.dart';
import 'screens/edit_product_screen.dart';
import 'screens/auth_screen.dart';

import 'providers/products.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => Auth()),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: ((context) => Products('', '', [])),
          update: (BuildContext ctx, auth, Products? previous) {
            return Products(auth.token, auth.userId,
                previous == null ? [] : previous.items);
          },
        ),
        ChangeNotifierProvider(
          create: ((context) => Cart()),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: ((context) => Orders('', '', [])),
          update: (context, auth, previous) {
            return Orders(auth.token, auth.userId,
                previous == null ? [] : previous.orders);
          },
        ),
      ],
      child: Consumer<Auth>(builder: ((ctx, auth, child) {
        return MaterialApp(
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
          home: auth.isAuth
              ? const ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: ((ctx, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : AuthScreen();
                  })),
          routes: {
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrdersScreens.routeName: ((ctx) => const OrdersScreens()),
            UserProductsScreen.routeName: ((ctx) => const UserProductsScreen()),
            EditProductScreen.routeName: ((ctx) => const EditProductScreen()),
          },
        );
      })),
    );
  }
}
