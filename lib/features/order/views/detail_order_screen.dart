import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/order.dart';
import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class DetailOrderScreen extends StatefulWidget {
  final String userName;
  final String avt;
  final List<Foods> foods;
  final String subTotal;
  final String distance;
  final String id;
  final List<int> quantity;
  final int index;

  const DetailOrderScreen({
    Key? key,
    required this.userName,
    required this.foods,
    required this.avt,
    required this.subTotal,
    required this.distance,
    required this.quantity,
    required this.id,
    required this.index
  }) : super(key: key);

  @override
  State<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  late double? height = 0;

  late int item = 0;
  late int commision = 0;
  late int totalMerchantGet = 0;

  getItem() {
    for (int i = 0; i < widget.quantity.length; i++) {
      item += widget.quantity[i];
    }
  }

  getCommision() {
    final int subTotal = int.parse(widget.subTotal);
    commision = (subTotal / 10).floor();
  }

  getTotalMerchantGet() {
    int subTotal = int.parse(widget.subTotal);
    totalMerchantGet = subTotal - commision;
  }

  getHeight() {
    if (widget.quantity.length == 1) {
      height = 20;
    } else if (widget.quantity.length == 2) {
      height = 50;
    } else if (widget.quantity.length == 3) {
      height = 80;
    } else if (widget.quantity.length == 4) {
      height = 100;
    } else if (widget.quantity.length == 5) {
      height = 120;
    }
  }

  @override
  void initState() {
    super.initState();
    getItem();
    getHeight();
    getCommision();
    getTotalMerchantGet();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    final int subTotal = int.parse(widget.subTotal);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pre-order"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding,
              ),
              height: 40,
              color: ColorLib.thirdColor,
              child: const Row(
                children: [
                  Text(
                    "Customer Note: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Cutlery needed",
                    style: TextStyle(color: ColorLib.primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        height: 50,
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.userName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.call,
                    color: ColorLib.primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 5,
              width: GetSize.getWidth(context),
              color: Colors.grey.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding * 2,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: height,
                    width: GetSize.getWidth(context),
                    child: ListView.builder(
                      itemCount: widget.foods.length,
                      itemBuilder: (context, index) {
                        return FoodCost(
                          cost: 1,
                            quantity: widget.quantity[index],
                            name: widget.foods[index].food?.name ?? "");
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subtotal (Origin Price)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(subTotal),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Commision (10%)",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(commision),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Merchant Receivable ($item items)",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(totalMerchantGet),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorLib.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 10,
              width: GetSize.getWidth(context),
              color: Colors.grey.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GetSize.symmetricPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order Code",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        widget.id,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Distance",
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        "${widget.distance} km",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorLib.primaryColor),
                    ),
                    height: 40,
                    width: GetSize.getWidth(context) / 2.5,
                    child: const Center(
                      child: Text(
                        "Cancel Order",
                        style: TextStyle(color: ColorLib.primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () async {
                    await Provider.of<OrderProvider>(context, listen: false).changeStatusToConfirmed(widget.id, "confirmed", widget.index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorLib.primaryColor,
                    ),
                    height: 40,
                    width: GetSize.getWidth(context) / 2.5,
                    child: const Center(
                      child: Text(
                        "Confirm Order",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FoodCost extends StatelessWidget {
  final String name;
  final int quantity;
  final int cost;

  const FoodCost({
    super.key,
    required this.quantity,
    required this.name,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$quantity x $name",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        Text(
        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(cost),
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
