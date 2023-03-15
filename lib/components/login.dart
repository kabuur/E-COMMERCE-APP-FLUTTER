import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/components/products.dart';
import 'package:e_commerce_app/components/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController passsword = new TextEditingController();
  bool isLoading = false;
  String err = '';
  login() async {
    try {
      isLoading = true;
      setState(() {});
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: passsword.text);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => Products(
                  currentEmail:
                      FirebaseAuth.instance.currentUser?.email ?? "")));
    } catch (e) {
      log(e.toString());
      err = "envaled user name or password";
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login Form"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 160),
            child: Column(
              children: [
                Text(
                  "SIGN IN ",
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 71, 192),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  err + "",
                  style: TextStyle(color: Color.fromARGB(255, 250, 1, 1)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 12, 1, 29),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Example@gmail.com",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                            controller: passsword,
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              login();
                              setState(() {});
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  )
                                : Text("Login"),
                          )),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Registration(),
                                      ));
                                });
                              },
                              child: Text(
                                "Registar Now",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
