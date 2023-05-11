import 'package:flutter/material.dart';
import 'package:flutter_project3_function/screen_2.dart';
import 'package:flutter_project3_function/splashscreen.dart';
import 'package:flutter_project3_function/update.dart';
import 'package:firebase_core/firebase_core.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => ScreenSpalash(),
        '/add': (context) => AddUser(),
        '/update': (context) => UpdateDonor(),
      },
      initialRoute: '/',
    );
  }
}
