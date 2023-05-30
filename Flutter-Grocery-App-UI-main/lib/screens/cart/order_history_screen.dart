import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'purchase_item.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final purchasedItems = Provider.of<List<PurchaseItem>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: purchasedItems.length,
        itemBuilder: (context, index) {
          final item = purchasedItems[index];

          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(item.productName),
          );
        },
      ),
    );
  }
}
