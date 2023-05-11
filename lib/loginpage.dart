import 'package:flutter/material.dart';
import 'package:flutter_project3_function/homepage_1.dart';
import 'package:flutter_project3_function/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isdatamatched = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(
                      'https://static.vecteezy.com/system/resources/previews/010/925/820/original/colorful-welcome-design-template-free-vector.jpg'),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: "Username",
                    ),
                    validator: (value) {
                      // if(_isdatamatched)
                      // {
                      //   return null;
                      // }else{
                      //   return 'Error';
                      // }
                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: "Password",
                    ),
                    validator: (value) {
                      // if(_isdatamatched)
                      // {
                      //   return null;
                      // }else{
                      //   return 'Error';
                      // }

                      if (value == null || value.isEmpty) {
                        return 'Value is Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                          visible: !_isdatamatched,
                          child: Text('Username password doesnot match')),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 252, 14, 14)),
                            iconColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 2, 2, 2)),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 76, 244, 54))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkLogin(context);
                          } else {
                            print('Data empty');
                          }
                        },
                        icon: Icon(Icons.check),
                        label: Text('SignIn'),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: 30,
                    ),
                    width: 300,
                    height: 300,
                    child: Image.network(
                      'https://media.istockphoto.com/id/662363360/vector/red-drop-blood-donation-transfusion.jpg?s=170667a&w=0&k=20&c=zc4dxCA-IQd1Yor7mfLoTAlqln0S652KeM9jJNiAhwM=',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkLogin(BuildContext ctx) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;
    if (_username == _password) {
      print('username pass match');
      //gotohome

      final _sharedprefs = await SharedPreferences.getInstance();
      await _sharedprefs.setBool(SAVE_KEY_NAME, true);

      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => Homepage()));
    } else {
      print('username pass doesnot match');
    }
  }
}
