import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../providers/order_provider.dart';
import '../../../../utils/size_lib.dart';
import 'detail_order_screen.dart';
import 'order_item.dart';

class OutgoingOrderScreen extends StatefulWidget {
  const OutgoingOrderScreen({super.key});

  @override
  State<OutgoingOrderScreen> createState() => _OutgoingOrderScreenState();
}

class _OutgoingOrderScreenState extends State<OutgoingOrderScreen> {

  double latitude = 0;
  double longtitude = 0;

  getLongLatitude()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      latitude = sharedPreferences.getDouble("latitude") ?? 0;
      longtitude = sharedPreferences.getDouble("longitude") ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    getLongLatitude();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderOutGoing(latitude, longtitude);
  }

  @override
  Widget build(BuildContext context) {
    return latitude != 0 ? SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrderOutGoing.isEmpty) {
                return const Center(
                  child: Text("No have item"),
                );
              } else if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 600,
                  width: GetSize.getWidth(context),
                  child: ListView.builder(
                    itemCount: value.listOrderOutGoing.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailOrderScreen(
                                  total: value.listOrderOutGoing[index].checkout?.total ?? 0,
                                  isOutgoing: true,
                                  index: index,
                                  foodCost: value.listOrderOutGoing[index].checkout?.totalPrice,
                                  phone: value.listOrderOutGoing[index].phoneNumber,
                                  foods: value.listOrderOutGoing[index].foods ?? [],
                                  avt: value.listOrderOutGoing[index].user?.avt ?? "",
                                  note: value.listOrderOutGoing[index].note,
                                  userName: value.listOrderOutGoing[index].user?.userName ?? "",
                                  subTotal: "${value.listOrderOutGoing[index].checkout
                                      ?.total}",
                                  distance: value.listOrderOutGoing[index].distance ?? "",
                                  id: value.listOrderOutGoing[index].sId ?? "",
                                  quantity: value.listOrderOutGoing[index].foods
                                  !.map((food) => food.quantity as int)
                                      .toList(), address: value.listOrderOutGoing[index].shippingAddress ?? "", feeShip: value.listOrderOutGoing[index].checkout?.feeShip ?? 0,
                                );
                              },
                            ),
                          );
                        },
                        child: OrderItem(
                          status: '',
                          distance:
                          value.listOrderOutGoing[index].distance ?? "",
                          createdAt:
                          value.listOrderOutGoing[index].createdAt ?? "",
                          dished:
                          value.listOrderOutGoing[index].foods!.length,
                          totalApplyDiscount: NumberFormat.currency(
                              locale: 'vi_VN', symbol: '₫')
                              .format(value.listOrderOutGoing[index].checkout
                              ?.total),
                          pickUp: DateFormat.Hm().format(
                            DateTime.parse(
                                value.listOrderOutGoing[index].updatedAt ??
                                    ""),
                          ), name: value.listOrderOutGoing[index].user?.userName ?? "",
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    ) : const Center(child: CircularProgressIndicator(),);
  }
}

