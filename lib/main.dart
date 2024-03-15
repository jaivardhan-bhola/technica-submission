import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uniride/pages/home.dart';
import 'package:uniride/pages/onboarding.dart';
Future main() async {
  await Hive.initFlutter();
  await dotenv.load(fileName: "lib/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Hive.openBox('user'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (Hive.box('user').isEmpty) {
            return Onboarding();
          } else {
            return Home();
          }
        },
      ),
    );
  }
}