import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/cart/order_history_screen.dart';
import 'package:grocery_app/screens/cart/purchase_item.dart';
import 'package:provider/provider.dart';
import 'package:grocery_app/screens/cart/purchase_item_list.dart';

import '../order_failed_dialog.dart';

class CheckoutBottomSheet extends StatefulWidget {
  final String productName;
  final List<PurchaseItem> purchasedItems;
  CheckoutBottomSheet({
    required this.productName,
    required this.purchasedItems,
  });
  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<List<PurchaseItem>, PurchaseItemList>(
      create: (_) => PurchaseItemList(),
      update: (_, purchasedItems, purchaseItemList) {
        purchaseItemList!.updateItems(purchasedItems);
        return purchaseItemList;
      },
      child: Consumer<PurchaseItemList>(
        builder: (context, purchaseItemList, _) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: new Wrap(
              children: <Widget>[
                Row(
                  children: [
                    AppText(
                      text: "Checkout",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 45),
                getDivider(),
                checkoutRow("Delivery", trailingText: "Select Method"),
                getDivider(),
                checkoutRow(
                  "Payment",
                  trailingWidget: Icon(
                    Icons.payment,
                  ),
                ),
                getDivider(),
                checkoutRow("Promo Code", trailingText: "Pick Discount"),
                getDivider(),
                checkoutRow("Total Cost", trailingText: "\$13.97"),
                getDivider(),
                SizedBox(height: 30),
                termsAndConditionsAgreement(context),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: AppButton(
                    label: "Place Order",
                    padding: EdgeInsets.symmetric(vertical: 25),
                    onPressed: () {
                      onPlaceOrderClicked(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

  Widget termsAndConditionsAgreement(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: 'By placing an order you agree to our',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 14,
            fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: " Terms",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: " And"),
            TextSpan(
              text: " Conditions",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
    );
  }

  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Row(
        children: [
          AppText(
            text: label,
            fontSize: 18,
            color: Color(0xFF7C7C7C),
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          trailingText == null
              ? (trailingWidget ?? Container())
              : AppText(
                  text: trailingText,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  void onPlaceOrderClicked(BuildContext context) {
    final newPurchaseItem = PurchaseItem(productName: widget.productName);

    final updatedPurchasedItems =
        List<PurchaseItem>.from(widget.purchasedItems);
    updatedPurchasedItems.add(newPurchaseItem);

    final purchaseItemProvider =
        Provider.of<List<PurchaseItem>>(context, listen: false);
    purchaseItemProvider.addAll(updatedPurchasedItems);

    Navigator.pop(context);
  }

  void purchaseProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Successful'),
          content: Text('Click the button below to receive your item.'),
          actions: [
            TextButton(
              child: Text('Receive Item'),
              onPressed: () {
                Navigator.of(context).pop();
                onPlaceOrderClicked(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class PurchaseItemList extends ChangeNotifier {
  List<PurchaseItem> _items = [];

  List<PurchaseItem> get items => _items;

  void updateItems(List<PurchaseItem> purchasedItems) {
    _items = purchasedItems;
    notifyListeners();
  }
}
