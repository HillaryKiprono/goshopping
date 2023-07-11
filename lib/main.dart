import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goshopping/admin/addCategory.dart';
import 'package:goshopping/homePage/categoryItem.dart';
import 'package:goshopping/homePage/homePage.dart';

import 'admin/adminModules/addItems.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoShopping',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:AddCategory(),
    );
  }
}

