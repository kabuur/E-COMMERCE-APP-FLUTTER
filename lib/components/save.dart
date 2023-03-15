import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool isLoading = false;
  TextEditingController name = new TextEditingController();
  TextEditingController tell = new TextEditingController();
  TextEditingController district = new TextEditingController();
  TextEditingController address = new TextEditingController();

  save() async {
    try {
      isLoading = true;
      setState(() {});

      await FirebaseFirestore.instance.collection("products").add({
        // "name": "Men's Winter Cotton Zipper Sweatshirt",
        // "image": "Sweatshirt",
        // "description": "Men's Winter Cotton Zipper Sweatshirt",
        // "price": 50
        // "name": name.text,
        // "tellphhone": tell.text,
        // "district": district.text,
        // "address": address.text
      });
      log("insert Success");
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Form"),
      ),
      body: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: TextField(
                      controller: tell,
                      decoration: InputDecoration(
                          hintText: "Tellphone",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: TextField(
                      controller: district,
                      decoration: InputDecoration(
                          hintText: "District",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: TextField(
                      controller: address,
                      decoration: InputDecoration(
                          hintText: "Address",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        save();
                        setState(() {});
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            )
                          : Text("Submit"),
                    )),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
