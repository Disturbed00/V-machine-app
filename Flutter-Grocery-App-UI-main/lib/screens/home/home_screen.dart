import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';
import 'package:grocery_app/screens/home/products_screen.dart';
import 'package:provider/provider.dart';

import '../cart/checkout_bottom_sheet.dart';
import '../cart/purchase_item.dart';
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

const LatLng currentLocation = LatLng(48.334140, 10.904972);
const LatLng randomLocation = LatLng(48.336267, 10.904444);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late GoogleMapController _mapController;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: currentLocation, zoom: 14),
        onMapCreated: ((controller) {
          _mapController = controller;
          addMarker('test', currentLocation, "Vending machine",
              "This is vending machine number 1");
          addMarker("test 1", randomLocation, "Vending machine #2",
              "This is vending machine number 2");
        }),
        markers: _markers.values.toSet(),
      ),
    );
  }

  void addMarker(String _Id, LatLng location, String _title, String _snippet) {
    var marker = Marker(
      markerId: MarkerId(_Id),
      position: location,
      infoWindow: InfoWindow(title: _title, snippet: _snippet),
      onTap: () => _onMarkerTapped(MarkerId(_Id)),
    );
    _markers[_Id] = marker;
    setState(() {});
  }

  void _onMarkerTapped(MarkerId markerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductsScreen(),
      ),
    );
  }
}
