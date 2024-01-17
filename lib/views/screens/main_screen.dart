import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/buyers_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/order_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/products_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/vendors_screen.dart';
import 'package:tuan_shop_web_admin/views/screens/side_bar_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = VendorsScreen();
        });
        break;

      case BuyersScreen.routeName:
        setState(() {
          _selectedItem = BuyersScreen();
        });
        break;

      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });
        break;

      case OrderScreen.routeName:
        setState(() {
          _selectedItem = OrderScreen();
        });
        break;

      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;

      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Quản Trị Viên'),
      ),
      sideBar: SideBar(
        textStyle: TextStyle(color: Color((0xFFE69138))),
        activeBackgroundColor: Color(0xFFE69138),
        items: [
          AdminMenuItem(
            title: 'Bảng điều khiển',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý Người Bán',
            icon: CupertinoIcons.person_3,
            route: VendorsScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý Người Mua',
            icon: CupertinoIcons.person,
            route: BuyersScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý rút tiền',
            icon: CupertinoIcons.money_dollar,
            route: WithdrawalScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý giao dịch đơn hàng',
            icon: CupertinoIcons.shopping_cart,
            route: OrderScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý danh mục sản phẩm',
            icon: Icons.category,
            route: CategoriesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý sản phẩm',
            icon: Icons.shop,
            route: ProductScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Quản lý Banner quảng cáo',
            icon: CupertinoIcons.add,
            route: UploadBannerScreen.routeName,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Tuan Store Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Nguyen Quang Tuan',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedItem,
    );
  }
}
