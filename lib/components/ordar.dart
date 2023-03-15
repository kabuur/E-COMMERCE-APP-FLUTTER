import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/components/producDetials.dart';
import 'package:e_commerce_app/components/products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Ordar extends StatefulWidget {
  const Ordar({
    super.key,
    this.currentEmail,
  });
  final currentEmail;

  @override
  State<Ordar> createState() => _OrdarState();
}

class _OrdarState extends State<Ordar> {
  delete(id) async {
    await FirebaseFirestore.instance.collection("ordar").doc(id).delete();
    print("deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ordar")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("ordar").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.data!.docs[index]['userEmail'] ==
                      widget.currentEmail) {
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                            image: AssetImage(
                                "images/${snapshot.data!.docs[index]['productImage']}")),
                      ),
                      title: Text(snapshot.data!.docs[index]['productName']),
                      subtitle: Row(
                        children: [
                          Text("\$" +
                              (snapshot.data!.docs[index]['price'] *
                                      snapshot.data!.docs[index]['orderQty'])
                                  .toString()),
                          SizedBox(
                            width: 22,
                          ),
                          Text("QTY " +
                              snapshot.data!.docs[index]['orderQty'].toString())
                        ],
                      ),
                      trailing: Row(children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Products()));
                              });
                            },
                            child: Icon(Icons.add)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              delete(snapshot.data!.docs[index].id);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ]),
                    );
                  }
                  return Center(child: Text(""));
                });
          }
          if (snapshot.hasError) {
            return (Center(
              child: Text("errr"),
            ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
