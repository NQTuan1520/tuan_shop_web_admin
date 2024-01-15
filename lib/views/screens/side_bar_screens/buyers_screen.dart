import 'package:flutter/material.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/widgets/buyers_list_widget.dart';

class BuyersScreen extends StatefulWidget {
  static const String routeName = '\buyersScreen';

  @override
  State<BuyersScreen> createState() => _BuyersScreenState();
}

class _BuyersScreenState extends State<BuyersScreen> {
  Widget _rowHeader(int flex, String text) {
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'THÔNG TIN NGƯỜI MUA',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  _rowHeader(1, 'ẢNH HỒ SƠ'),
                  _rowHeader(2, 'HỌ VÀ TÊN'),
                  _rowHeader(2, 'EMAIL'),
                  _rowHeader(3, 'ĐỊA CHỈ'),
                  _rowHeader(1, 'ĐIỆN THOẠI'),
                  _rowHeader(1, 'XOÁ'),
                ],
              ),
              BuyersListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
