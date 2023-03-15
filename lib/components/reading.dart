import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReadDate extends StatefulWidget {
  const ReadDate({super.key});

  @override
  State<ReadDate> createState() => _ReadDateState();
}

class _ReadDateState extends State<ReadDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("reading data")),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("personInfo").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) => ListTile(
                        title: Text(snapshot.data!.docs[index]['name']),
                        subtitle: Text(snapshot.data!.docs[index]["address"]),
                        
                      )));
            }
            if (snapshot.hasError) {
              return Center(child: Text("error"));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
