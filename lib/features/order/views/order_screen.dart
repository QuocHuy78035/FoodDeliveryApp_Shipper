import 'package:ddnangcao_project/features/order/views/new_order_screen.dart';
import 'package:ddnangcao_project/features/order/views/outgoing_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/color_lib.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  Position? _currentLocation;
  late bool servicePermission = true;
  late LocationPermission permission;

  String currentAddress = '';

  Future<void> _getCurrentLocationAndAddress() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    try {
      _currentLocation = await _getCurrentLocation();
      sharedPreferences.setDouble("latitude", _currentLocation!.latitude);
      sharedPreferences.setDouble("longitude", _currentLocation!.longitude);
      await _getAddress();
    } catch (e) {
      print("Error getting current location and address: $e");
    }
  }

  Future<Position> _getCurrentLocation() async {
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddress() async {
    try {
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      List<Placemark> placesmarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      if (placesmarks.isNotEmpty) {
        Placemark placemark = placesmarks[0];
        if (mounted) {
          setState(() {
            currentAddress =
            "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}, ";
          });
          sharedPreferences.setString("address", currentAddress);
        }
      } else {
        setState(() {
          currentAddress = "Không thể tìm thấy địa chỉ.";
        });
      }
    } catch (e) {
      print("Error getting address: $e");
      setState(() {
        currentAddress = "Lỗi khi lấy địa chỉ.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    try {
      await _getCurrentLocationAndAddress();
    } catch (e) {
      print("Error initializing state: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool locationAvailable =
        _currentLocation != null && currentAddress.isNotEmpty;
    return locationAvailable == true ? DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("My Order"),
          bottom: const TabBar(
            padding: EdgeInsets.symmetric(horizontal: 0),
            isScrollable: true,
            indicatorColor: ColorLib.primaryColor,
            indicatorWeight: 5,
            tabs: [
              RepeatedTab(
                label: "Schedule",
              ),
              RepeatedTab(
                label: "Delivered",
              ),
              // RepeatedTab(
              //   label: "New",
              // ),
              // RepeatedTab(
              //   label: "Out going",
              // ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewOrderScreen(),
            OutgoingOrderScreen(),
            // Center(
            //   child: Text("Shoes"),
            // ),
            // Center(
            //   child: Text("Shoes"),
            // ),
          ],
        ),
      ),
    ) : const Center(child: CircularProgressIndicator(),);
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;

  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow),
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            const Text(
              "What are you looking for?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Container(
              height: 32,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.yellow),
              child: const Center(
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
