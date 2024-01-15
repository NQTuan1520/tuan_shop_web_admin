import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ProductListWidget extends StatefulWidget {
  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final Stream<QuerySnapshot> _orderStream =
  FirebaseFirestore.instance.collection('products').snapshots();

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
      stream: _orderStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        return SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              final order = snapshot.data!.docs[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  vendorData(
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          order['imageUrl'][0],
                          width: 50,
                          height: 50,
                        ),
                      ),
                      1),
                  vendorData(
                      Text(
                        order['productName'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      2),
                  vendorData(
                      Text(
                        "\$" + ' ' + order['productPrice'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      1),
                  vendorData(
                      Text(
                        order['quantity'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      1),
                  vendorData(
                      Text(
                        order['businessName'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      2),
                  vendorData(
                      order['approved'] == false
                          ? ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc(order['productID'])
                                .update({
                              'approved': true,
                            });
                          },
                          child: Text(
                            'ĐỒNG Ý',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ))
                          : ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(order['productID'])
                              .update({
                            'approved': false,
                          });
                        },
                        child: Text(
                          'TỪ CHỐI',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                      1),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
