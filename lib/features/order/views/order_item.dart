import 'package:flutter/material.dart';

import '../../../utils/color_lib.dart';
import '../../../utils/size_lib.dart';

class OrderItem extends StatelessWidget {
  final String? status;
  final String name;
  final String totalApplyDiscount;
  final int dished;
  final String createdAt;
  final String pickUp;
  final String distance;

  const OrderItem(
      {super.key,
        this.status,
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
              status ?? "",
              style: const TextStyle(
                fontSize: 16,
                color: ColorLib.primaryColor,
              ),
            ),
            Text(
              createdAt,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
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
