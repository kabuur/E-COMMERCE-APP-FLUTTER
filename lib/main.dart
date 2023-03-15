import 'package:e_commerce_app/components/login.dart';
import 'package:e_commerce_app/components/products.dart';
import 'package:e_commerce_app/components/reading.dart';
import 'package:e_commerce_app/components/registration.dart';
import 'package:e_commerce_app/components/save.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    home: Login(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-commerce App")),
      body: Center(
        child: Text("centered"),
      ),
    );
  }
}
