import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cart/purchase_item.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/screens/cart/purchase_item_list.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PurchaseItemList>(
      create: (_) => PurchaseItemList(),
      child: MyApp(),
    ),
  );
}
