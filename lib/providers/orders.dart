import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  // ignore: prefer_final_fields
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://flutter-course-e58ea-default-rtdb.europe-west1.firebasedatabase.app/Orders.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amout'],
          products: (orderData['product'] as List<dynamic>).map((e) {
            return CartItem(
                id: e['id'],
                title: e['title'],
                quantity: e['quantity'],
                price: e['price']);
          }).toList(),
          dateTime: DateTime.parse(
            orderData['dateTime'],
          ),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<Null> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://flutter-course-e58ea-default-rtdb.europe-west1.firebasedatabase.app/Orders.json');

    final timestamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          'amout': total,
          'dateTime': timestamp.toIso8601String(),
          'product': cartProducts.map((e) {
            return {
              'id': e.id,
              'title': e.title,
              'quantity': e.quantity,
              'price': e.price,
            };
          }).toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timestamp));
    notifyListeners();
  }
}
