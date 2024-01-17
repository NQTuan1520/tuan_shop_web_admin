import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tuan_shop_web_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid || Platform.isIOS
          ? FirebaseOptions(
              apiKey: 'AIzaSyBPcB-YV5saXVjTWMsbDQ_7Lr89CjzToAM',
              appId: '1:851800943545:web:49ba7ce1f35ee81fcbe468',
              messagingSenderId: '851800943545',
              projectId: 'store-e82c3',
              storageBucket: 'store-e82c3.appspot.com',
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
