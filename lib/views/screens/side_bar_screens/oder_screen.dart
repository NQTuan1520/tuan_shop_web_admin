import 'package:flutter/material.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/widgets/order_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const String routeName = '\orderScreen';

  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          color: Colors.yellow.shade900,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Orders',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('IMAGE', 1),
              _rowHeader('PRODUCT NAME', 1),
              _rowHeader('FULL NAME', 2),
              _rowHeader('ADDRESS', 3),
              _rowHeader('ACTION', 1),
            ],
          ),
          OrderWidget(),
        ],
      ),
    );
  }
}
