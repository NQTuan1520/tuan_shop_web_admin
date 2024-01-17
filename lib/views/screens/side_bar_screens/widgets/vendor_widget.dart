import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/vendor_user_models.dart';

class VendorList extends StatefulWidget {
  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('vendors').snapshots();

  Widget vendorData(Widget widget, int? flex) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) {
            VendorUserModel vendor = VendorUserModel.fromJson(
                snapshot.data!.docs[index].data() as Map<String, dynamic>);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vendorData(
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                        vendor.storeImage.toString(),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    1),
                vendorData(
                    Text(
                      vendor.businessName.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),
                vendorData(
                    Text(
                      vendor.phoneNumber.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    1),
                vendorData(
                    Text(
                      vendor.cityValue.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),
                vendorData(
                    Text(
                      vendor.stateValue.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    1),
                vendorData(
                    vendor.approved == true
                        ? ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('vendors')
                                  .doc(vendor.vendorId)
                                  .update({
                                'approved': false,
                              });
                            },
                            child: Text(
                              'TỪ CHỐI',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ))
                        : ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('vendors')
                                  .doc(vendor.vendorId)
                                  .update({
                                'approved': true,
                              });
                            },
                            child: Text(
                              'ĐỒNG Ý',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ),
                    2),
                vendorData(
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('CẢNH BÁO'),
                                content: Text(
                                    'Bạn có thực sự muốn xoá tài khoản Người Bán này ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Huỷ'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final vendorId = vendor.vendorId;

                                      final productsQuery =
                                          await FirebaseFirestore.instance
                                              .collection('products')
                                              .where('vendorId',
                                                  isEqualTo: vendorId)
                                              .get();

                                      for (final doc in productsQuery.docs) {
                                        await doc.reference.delete();
                                      }

                                      // Xoá tài khoản vendor
                                      await FirebaseFirestore.instance
                                          .collection('vendors')
                                          .doc(vendorId)
                                          .delete();

                                      setState(() {
                                        snapshot.data!.docs.removeAt(index);
                                      });

                                      Navigator.pop(
                                          context); // Đóng hộp thoại sau khi xoá thành công
                                    },
                                    child: Text('Đồng ý'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'XOÁ',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        )),
                    1),
              ],
            );
          }),
        );
      },
    );
  }
}
