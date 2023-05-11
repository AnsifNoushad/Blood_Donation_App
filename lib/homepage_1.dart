import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  final CollectionReference donor = FirebaseFirestore.instance.collection('donor');

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference donor = 
  FirebaseFirestore.instance.collection('donor');


  void deleteDonor(docId){
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Blood Donation App'),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/add');
      },
      backgroundColor: Color.fromARGB(255, 83, 235, 46),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
        ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

    body: StreamBuilder(
      stream: donor.orderBy('name'). snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot donorSnap = snapshot.data.docs[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 226, 217, 217),
                      blurRadius: 10,
                      spreadRadius: 15,
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                Container(
                  child: Padding( 
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: Text(donorSnap['group'],
                      style: TextStyle(
                        fontSize: 25,
                      ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(donorSnap['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    Text(donorSnap['number'].toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 30,
                       color: Colors.blue,
                      onPressed: () {
                        Navigator.pushNamed(context, '/update',
                        arguments: {
                          'name' : donorSnap['name'],
                          'number' : donorSnap['number'].toString(),
                          'group' : donorSnap['group'],
                          'id' : donorSnap.id,
                        }
                        
                        );
                      },
                       icon: Icon(Icons.edit),
                       ),
                    IconButton(
                      iconSize: 30,
                      color: Colors.red,
                      onPressed: () {
                        deleteDonor(donorSnap.id);
                      },
                     icon: Icon(Icons.delete),
                    )
                  ],
                )
               ],
                ),
              ),
            );
          },
          );
        }
        return Container();
      },
    ),
    );
  }
}