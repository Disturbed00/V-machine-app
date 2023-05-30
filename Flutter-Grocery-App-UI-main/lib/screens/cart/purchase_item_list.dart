import 'package:flutter/material.dart';
import 'package:grocery_app/screens/cart/purchase_item.dart';

class PurchaseItemList extends ChangeNotifier {
  List<PurchaseItem> _items = [];

  List<PurchaseItem> get items => _items;

  void updateItems(List<PurchaseItem> purchasedItems) {
    _items = purchasedItems;
    notifyListeners();
  }
}
