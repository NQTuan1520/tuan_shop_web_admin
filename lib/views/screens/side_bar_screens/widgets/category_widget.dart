import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String? selectedFileName;
  bool deletionSuccess = false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
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

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No Categories\n Added yet',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 30,
              ),
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
              final categoryData = snapshot.data!.docs[index];
              final String categoryId = categoryData.reference.id;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Khi ấn vào ảnh, thiết lập giá trị của selectedFileName tương ứng
                          selectedFileName = categoryId;
                        });
                      },
                      child: SizedBox(
                        height: 90,
                        width: 100,
                        child: Image.network(
                          categoryData['image'],
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        categoryData['categoryName'],
                      ),
                    ),
                    if (selectedFileName == categoryId)
                      ElevatedButton(
                        onPressed: () {
                          _deleteProduct(categoryId);
                          setState(() {
                            // Đặt lại giá trị selectedFileName để ẩn nút Delete sau khi xoá ảnh
                            selectedFileName = null;
                          });
                        },
                        child: Text('Delete'),
                      ),
                    if (deletionSuccess)
                      Text(
                        'Category deleted successfully!',
                        style: TextStyle(color: Colors.green),
                      ),
                  ],
                ),
              );
            });
      },
    );
  }

  void _deleteProduct(String categoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
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
      // Xử lý lỗi nếu có
      print('Error deleting product: $e');
      // Hiển thị thông báo hoặc cập nhật UI nếu cần thiết
      // Ví dụ: Hiển thị thông báo lỗi
    }
  }
}
