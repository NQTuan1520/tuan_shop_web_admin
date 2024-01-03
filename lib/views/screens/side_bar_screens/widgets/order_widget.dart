import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  final Stream<QuerySnapshot> _orderStrem =
  FirebaseFirestore.instance.collection('orders').snapshots();

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
      stream: _orderStrem,
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
            final vendor = snapshot.data!.docs[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vendorData(
                    Container(
                      height: 50,
                      width: 50,
                      child: Image.network(
                        vendor['productImage'][0],
                        width: 50,
                        height: 50,
                      ),
                    ),
                    1),

                vendorData(
                    Text(
                      vendor['productName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    1),

                vendorData(
                    Text(
                      vendor['fullName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    2),

                vendorData(
                    Text(
                      vendor['placeName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    3),

                vendorData(
                    ElevatedButton(
                        onPressed: () async {},
                        child: Text(
                          'Reject',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
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
