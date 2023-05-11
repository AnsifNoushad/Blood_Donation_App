import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project3_function/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  final bloodGroup = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedGroup;

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorNumber = TextEditingController();

  void addDonor() {
    final data = {
      'name': donorName.text,
      'number': donorNumber.text,
      'group': selectedGroup,
    };
    donor.add(data);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Donors'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: donorName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Donor Name'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: donorNumber,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Phone Number'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      label: Text('Select Blood Group'),
                    ),
                    items: bloodGroup
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      selectedGroup = val;
                    }),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (donorName.text != '' &&
                        donorNumber.text != '' &&
                        selectedGroup != null) {
                      addDonor();
                      Navigator.pop(context);
                    } else {
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => Navigator.pop(context));
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text('Fill all the fields to submit '),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: 300,
                  left: 280,
                ),
                child: Column(
                  children: [
                    IconButton(
                      iconSize: 30,
                      onPressed: () {
                        signout(context);
                      },
                      icon: Icon(Icons.exit_to_app),
                    ),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signout(BuildContext ctx) async {
    final _sharedprefs = await SharedPreferences.getInstance();
    await _sharedprefs.clear();

    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => Loginpage()), (route) => false);
  }
}
