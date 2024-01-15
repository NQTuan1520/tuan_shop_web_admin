import 'package:flutter/material.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/widgets/withdrawal_widget.dart';

class WithdrawalScreen extends StatefulWidget {

  static const String routeName = '\WithdrawalScreen';

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'THÔNG TIN RÚT TIỀN',
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
                _rowHeader(2, 'TÊN NGƯỜI NHẬN'),
                _rowHeader(1, 'TIỀN'),
                _rowHeader(2, 'TÊN NGÂN HÀNG'),
                _rowHeader(2, 'SỐ TÀI KHOẢN NGÂN HÀNG'),
                _rowHeader(1, 'EMAIL'),
                _rowHeader(1, 'ĐIỆN THOẠI'),
              ],
            ),
            WithdrawalList(),
          ],
        ),
      ),
    );
  }
}
