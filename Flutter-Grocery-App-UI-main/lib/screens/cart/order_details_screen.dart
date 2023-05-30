import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String productName;

  const OrderDetailsScreen({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ordered Item: $productName',
              style: TextStyle(fontSize: 18),
            ),
            // Add additional widgets to display the list of previous purchases
          ],
        ),
      ),
    );
  }
}
