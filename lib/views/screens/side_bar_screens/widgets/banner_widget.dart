import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  String? selectedBannerId;
  bool deletionSuccess = false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _bannerStream =
        FirebaseFirestore.instance.collection('banners').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _bannerStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.size,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final bannerData = snapshot.data!.docs[index];
            final String bannerId = bannerData.reference.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedBannerId = bannerId;
                });
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    width: 100,
                    child: Image.network(
                      bannerData['image'],
                    ),
                  ),
                  if (selectedBannerId == bannerId)
                    ElevatedButton(
                      onPressed: () {
                        _deleteBanner(bannerId);
                        setState(() {
                          selectedBannerId = null;
                        });
                      },
                      child: Text('Xoá'),
                    ),
                  if (deletionSuccess)
                    Text(
                      'Banner đã được xoá thành công!',
                      style: TextStyle(color: Colors.green),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _deleteBanner(String bannerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('banners')
          .doc(bannerId)
          .delete();
      setState(() {
        deletionSuccess = true;
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          deletionSuccess = false;
        });
      });
    } catch (e) {
      print('Error deleting banner: $e');
    }
  }
}
