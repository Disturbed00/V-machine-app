import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grocery_app/screens/cart/checkout_bottom_sheet.dart';
import 'package:grocery_app/screens/cart/purchase_item.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.local_drink),
            title: Text('Black Forest water 0.5L'),
            onTap: () =>
                _showCheckoutBottomSheet(context, 'Black Forest water 0.5L'),
          ),
          ListTile(
            leading: Icon(Icons.local_drink),
            title: Text('Pepsi 0.5L'),
            onTap: () => _showCheckoutBottomSheet(context, 'Pepsi 0.5L'),
          ),
          ListTile(
            leading: Icon(Icons.local_bar_rounded),
            title: Text('Twix'),
            onTap: () => _showCheckoutBottomSheet(context, 'Twix'),
          ),
          ListTile(
            leading: Icon(Icons.local_dining_rounded),
            title: Text('Drink'),
            onTap: () => _showCheckoutBottomSheet(context, 'Drink'),
          ),
          // Add more list items for other products
        ],
      ),
    );
  }

  void _showCheckoutBottomSheet(BuildContext context, String productName) {
    showModalBottomSheet(
      context: context,
      builder: (_) => CheckoutBottomSheet(
        productName: productName,
        purchasedItems: context.read<List<PurchaseItem>>(),
      ),
    );
  }
}
