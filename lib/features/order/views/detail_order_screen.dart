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
  final String address;
  final List<Foods> foods;
  final String subTotal;
  final String distance;
  final String id;
  final List<int> quantity;
  final String? note;
  final int? foodCost;
  final int index;
  final String? phone;
  final bool? isPending;
  final bool? isOutgoing;
  final int feeShip;
  final int total;

  const DetailOrderScreen(
      {Key? key,
      required this.userName,
      required this.address,
        required this.feeShip,
      required this.foods,
        this.isOutgoing = false,
        required this.total,
      this.phone,
      this.foodCost,
      required this.avt,
      required this.subTotal,
      required this.distance,
      required this.quantity,
      required this.id,
      this.note,
        this.isPending = false,
      required this.index})
      : super(key: key);

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
    commision = (widget.foodCost ?? 0 / 10).floor();
  }

  getTotalMerchantGet() {
    int subTotal = int.parse(widget.subTotal);
    totalMerchantGet = widget.foodCost ?? 0 - commision;
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
              child: Row(
                children: [
                  const Text(
                    "Customer Note: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.note ?? "Don't have",
                    style: const TextStyle(color: ColorLib.primaryColor, fontSize: 18),
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
                      SizedBox(
                        height: 50,
                        child: Image.network(widget.avt),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            widget.phone ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: height,
                    width: GetSize.getWidth(context),
                    child: ListView.builder(
                      itemCount: widget.foods.length,
                      itemBuilder: (context, index) {
                        return FoodCost(
                            cost: widget.foodCost ?? 0,
                            quantity: widget.quantity[index],
                            name: widget.foods[index].food?.name ?? "");
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shipping address",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.address,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       "Subtotal (Origin Price)",
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //     Text(
                  //       NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                  //           .format(subTotal),
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       "Commision (10%)",
                  //       style: TextStyle(
                  //         fontSize: 17,
                  //       ),
                  //     ),
                  //     Text(
                  //       NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                  //           .format(commision),
                  //       style: const TextStyle(fontSize: 17),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(widget.total),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ColorLib.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Shipper Receivable",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                            .format(widget.feeShip),
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
            child: widget.isOutgoing == false ? Row(
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
                        "Cancel Ship",
                        style: TextStyle(color: ColorLib.primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () async {
                    await Provider.of<OrderProvider>(context, listen: false)
                        .changeStatusToNew(
                            widget.id, "new", widget.index);
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
                        "Confirm Ship",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ) : GestureDetector(
              onTap: () async {
                await Provider.of<OrderProvider>(context, listen: false)
                    .changeStatusToNew(
                    widget.id, "delivered", widget.index);
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorLib.primaryColor,
                ),
                child: const Center(
                  child: Text(
                    "Delivered",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
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
          NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(cost),
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
