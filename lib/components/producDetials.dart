import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/components/login.dart';
import 'package:e_commerce_app/components/ordar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Detials extends StatefulWidget {
  const Detials(
      {super.key,
      required QueryDocumentSnapshot<Object?> this.product,
      this.currentEmail});
  final QueryDocumentSnapshot<Object?> product;
  final currentEmail;
  @override
  State<Detials> createState() => _DetialsState();
}

String QTYvalue = '1';
bool isLoading = false;
int qty = int.parse(QTYvalue);

class _DetialsState extends State<Detials> {
  save() async {
    try {
      isLoading = true;
      setState(() {});

      await FirebaseFirestore.instance.collection("ordar").add({
        "productName": widget.product['name'],
        "productImage": widget.product['image'],
        "description": widget.product['description'],
        "price": widget.product['price'],
        "orderQty": qty,
        "userEmail": widget.currentEmail
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Ordar(currentEmail: widget.currentEmail)));
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 12,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    Text(
                      "Log out",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              Text(
                "Product Details",
                style: TextStyle(fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ordar(
                                  currentEmail: widget.currentEmail,
                                )));
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 33,
                    ),
                    Text(
                      "Your Cards",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 255, 255, 255)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'images/${widget.product["image"]}')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product["name"]),
                  Row(
                    children: [
                      Expanded(
                          child: Text("price\$${widget.product["price"]}")),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text("QTY"),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                                value: QTYvalue,
                                icon: Icon(Icons.arrow_downward),
                                items: [
                                  DropdownMenuItem(
                                      value: "1", child: Text("1")),
                                  DropdownMenuItem(
                                      value: "2", child: Text("2")),
                                  DropdownMenuItem(
                                      value: "3", child: Text("3")),
                                  DropdownMenuItem(
                                      value: "4", child: Text("4")),
                                  DropdownMenuItem(
                                      value: "5", child: Text("5")),
                                  DropdownMenuItem(
                                      value: "6", child: Text("6")),
                                  DropdownMenuItem(
                                      value: "7", child: Text("7")),
                                  DropdownMenuItem(
                                      value: "8", child: Text("8")),
                                  DropdownMenuItem(
                                      value: "9", child: Text("9")),
                                  DropdownMenuItem(
                                      value: "10", child: Text("10")),
                                ],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    QTYvalue = newValue.toString();
                                  });
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(widget.product['description']),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          save();
                        });
                      },
                      child: Text("ORDAR NOW"))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
