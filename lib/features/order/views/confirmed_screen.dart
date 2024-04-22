import 'package:ddnangcao_project/features/order/views/detail_order_screen.dart';
import 'package:ddnangcao_project/providers/order_provider.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/color_lib.dart';
import 'package:intl/intl.dart';

class ConfirmedScreen extends StatefulWidget {
  const ConfirmedScreen({super.key});

  @override
  State<ConfirmedScreen> createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<OrderProvider>(
            builder: (context, value, child) {
              if (value.listOrderConfirmed.isEmpty) {
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
                    itemCount: value.listOrderConfirmed.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailOrderScreen(
                                  index: index,
                                  foods: value.listOrderConfirmed[index].foods ?? [],
                                  avt: "",
                                  userName: value.listOrderConfirmed[index].user?.userName ?? "",
                                  subTotal: "${value.listOrderConfirmed[index].checkout
                                      ?.totalApplyDiscount}",
                                  distance: value.listOrderConfirmed[index].distance ?? "",
                                  id: value.listOrderConfirmed[index].sId ?? "",
                                  quantity: value.listOrderConfirmed[index].foods
                                  !.map((food) => food.quantity as int)
                                      .toList(),
                                );
                              },
                            ),
                          );
                        },
                        child: OrderItem(
                          dished: value.listOrderConfirmed[index].foods!.length,
                          totalApplyDiscount:
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(value.listOrderConfirmed[index].checkout
                              ?.totalApplyDiscount),
                          name:
                          value.listOrderConfirmed[index].user?.userName ?? "",

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
  const OrderItem(
      {super.key,
        required this.name,
        required this.totalApplyDiscount,
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
            const Divider(
              color: Colors.black,
            ),
            const Row(
              children: [
                Text("Status: "),
                Text("Waiting driver to confirm the order.", style: TextStyle(fontSize: 18, color: Colors.orange),)
              ],
            ),
            Row(
              children: [
                Text("$dished dished"),
                Text(
                  totalApplyDiscount,
                  style: const TextStyle(
                      color: ColorLib.primaryColor, fontSize: 18),
                )
              ],
            ),
            Container(
              height: 20,
              width: GetSize.getWidth(context),
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
