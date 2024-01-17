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
          color: Colors.orange,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              'GIAO DỊCH ĐƠN HÀNG',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('ẢNH', 1),
              _rowHeader('TÊN SẢN PHẨM', 1),
              _rowHeader('GIÁ TIỀN', 1),
              _rowHeader('SỐ LƯỢNG MUA', 1),
              _rowHeader('TÊN NGƯỜI MUA', 2),
              _rowHeader('ĐỊA CHỈ NHẬN HÀNG', 2),
            ],
          ),
          OrderWidget(),
        ],
      ),
    );
  }
}
