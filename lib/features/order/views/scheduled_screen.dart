import 'package:ddnangcao_project/features/order/views/detail_order_screen.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import 'package:intl/intl.dart';

class ScheduledScreen extends StatefulWidget {
  const ScheduledScreen({super.key});

  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderPending();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrderScheduled.isEmpty) {
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
                    itemCount: value.listOrderScheduled.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailOrderScreen(
                                  index: index,
                                  foods: value.listOrderScheduled[index].foods ?? [],
                                  avt: "",
                                  userName: value.listOrderScheduled[index].user?.userName ?? "",
                                  subTotal: "${value.listOrderScheduled[index].checkout
                                      ?.totalApplyDiscount}",
                                  distance: value.listOrderScheduled[index].distance ?? "",
                                  id: value.listOrderScheduled[index].sId ?? "",
                                  quantity: value.listOrderScheduled[index].foods
                                  !.map((food) => food.quantity as int)
                                      .toList(),
                                );
                              },
                            ),
                          );
                        },
                        child: OrderItem(
                          distance: value.listOrderScheduled[index].distance ?? "",
                          createdAt:
                          value.listOrderScheduled[index].createdAt ?? "",
                          dished: value.listOrderScheduled[index].foods!.length,
                          totalApplyDiscount:
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(value.listOrderScheduled[index].checkout
                              ?.totalApplyDiscount),
                          name:
                          value.listOrderScheduled[index].user?.userName ?? "",
                          pickUp: DateFormat.Hm().format(
                            DateTime.parse(
                                value.listOrderScheduled[index].updatedAt ?? ""),
                          ),
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
    );
  }
}

class OrderItem extends StatelessWidget {
  final String name;
  final String totalApplyDiscount;
  final int dished;
  final String createdAt;
  final String pickUp;
  final String distance;

  const OrderItem(
      {super.key,
      required this.name,
      required this.distance,
      required this.pickUp,
      required this.totalApplyDiscount,
      required this.createdAt,
      required this.dished});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26.withOpacity(.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: GetSize.symmetricPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            Text(
              createdAt,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Picked up",
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.6)),
                    ),
                    Text(
                      pickUp,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Dished",
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(.6)),
                    ),
                    Text("$dished")
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Distance",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(.6),
                      ),
                    ),
                    Text("$distance km")
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Total: ",
                  style: TextStyle(fontSize: 20, color: ColorLib.primaryColor),
                ),
                Text(
                  totalApplyDiscount,
                  style: const TextStyle(
                      color: ColorLib.primaryColor, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 2,
              width: GetSize.getWidth(context),
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
