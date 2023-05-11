import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_project3_function/homepage_1.dart';
import 'package:flutter_project3_function/loginpage.dart';
import 'package:flutter_project3_function/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSpalash extends StatefulWidget {
  const ScreenSpalash({super.key});

  @override
  State<ScreenSpalash> createState() => _ScreenSpalashState();
}

class _ScreenSpalashState extends State<ScreenSpalash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            'https://www.pngmart.com/files/7/Blood-Donation-PNG-Picture.png'),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<Void?> gotoLogin() async {
    await Future.delayed(
      Duration(seconds: 4),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Loginpage(),
      ),
    );
    return null;
  }

  void checkUserLoggedIn() async {
    final _sharedprefs = await SharedPreferences.getInstance();
    // _sharedprefs.getBool(SAVE_KEY_NAME, true)
    final _userLoggedIn = _sharedprefs.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => Homepage(),
        ),
      );
    }
  }
}
