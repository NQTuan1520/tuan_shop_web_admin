import 'package:flutter/material.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/widgets/product_list_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const String routeName = '\ProductScreen';

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
              'SẢN PHẨM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('ẢNH', 1),
              _rowHeader('NAME', 2),
              _rowHeader('NHÃN HÀNG', 1),
              _rowHeader('GIÁ TIỀN', 1),
              _rowHeader('SỐ LƯỢNG', 1),
              _rowHeader('TÊN CÔNG TY', 1),
              _rowHeader('KIỂM DUYỆT', 1),
            ],
          ),
          ProductListWidget(),
        ],
      ),
    );
  }
}
