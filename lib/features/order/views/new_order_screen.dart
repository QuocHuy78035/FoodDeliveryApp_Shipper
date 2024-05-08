import 'package:ddnangcao_project/features/order/views/order_item.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_order_screen.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {

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
    Provider.of<OrderProvider>(context, listen: false).getAllOrderConfirm(latitude, longtitude);
  }

  @override
  Widget build(BuildContext context) {
    return latitude != 0 ? SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrder.isEmpty) {
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
                    itemCount: value.listOrder.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailOrderScreen(
                                  total: value.listOrderOutGoing[index].checkout?.total ?? 0,
                                  feeShip: value.listOrder[index].checkout?.feeShip ?? 0,
                                  address : value.listOrder[index].shippingAddress ?? "",
                                  index: index,
                                  foods: value.listOrder[index].foods ?? [],
                                  avt: value.listOrder[index].user?.avt ?? "",
                                  userName:
                                      value.listOrder[index].user?.userName ??
                                          "",
                                  subTotal:
                                      "${value.listOrder[index].checkout?.totalApplyDiscount}",
                                  distance:
                                      value.listOrder[index].distance ?? "",
                                  id: value.listOrder[index].sId ?? "",
                                  quantity: value.listOrder[index].foods!
                                      .map((food) => food.quantity as int)
                                      .toList(),
                                  foodCost: value.listOrder[index].checkout?.totalPrice,
                                );
                              },
                            ),
                          );
                        },
                        child: OrderItem(
                          status: 'Wait for you confirm',
                          distance: value.listOrder[index].distance ?? "",
                          pickUp: value.listOrder[index].createdAt ?? "",
                          createdAt: value.listOrder[index].createdAt ?? "",
                          dished: value.listOrder[index].foods!.length,
                          name: value.listOrder[index].user?.userName ?? "",
                          totalApplyDiscount:NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(value.listOrder[index].checkout
                              ?.totalPrice),
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
