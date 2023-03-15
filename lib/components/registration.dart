import 'dart:developer';

import 'package:e_commerce_app/components/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var isloading = false;
  register() async {
    try {
      isloading = true;
      setState(() {});
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
    } catch (e) {
      log(e.toString());
    }
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Regestration Form"),
      ),
      body: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 160),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Example@gmail.com",
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
                      controller: password,
                      decoration: InputDecoration(
                          hintText: "Password",
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
                        register();
                      },
                      child: isloading
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            )
                          : Text("Sign uP"),
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
