import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WithdrawalList extends StatefulWidget {
  const WithdrawalList({super.key});


  @override
  State<WithdrawalList> createState() => _WithdrawalListState();
}

class _WithdrawalListState extends State<WithdrawalList> {
  final Stream<QuerySnapshot> _withdrewStream =
  FirebaseFirestore.instance.collection('withdrawal').snapshots();
  Widget withdrewdata(Widget widget, int? flex) {
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
      stream: _withdrewStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: LinearProgressIndicator());
        }

        return Container(
          height: 400,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              final _withdrewData = snapshot.data!.docs[index];
              return Row(
                children: [
                  withdrewdata(
                      Text(
                        _withdrewData['BankAccountName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      2),
                  withdrewdata(
                      Text(
                        '\$' + " " + _withdrewData['Amount'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      1),
                  withdrewdata(
                      Text(
                        _withdrewData['BankName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      2),
                  withdrewdata(
                      Text(
                        _withdrewData['BankAccountNumber'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      2),
                  withdrewdata(
                      Text(
                        _withdrewData['Mobile'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      1),
                  withdrewdata(
                      Text(
                        _withdrewData['Name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      1)
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
