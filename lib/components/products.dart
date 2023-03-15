import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/components/login.dart';
import 'package:e_commerce_app/components/ordar.dart';
import 'package:e_commerce_app/components/producDetials.dart';
import 'package:e_commerce_app/components/reading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatefulWidget {
  const Products({super.key, this.currentEmail});
  final currentEmail;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var images = [
    "images/ANTAX-GAMESHOES.jpg",
    "images/BlackStripesSHOES.jpg",
    "images/CasioWatchforMen.jpg",
    "images/GoldWristwatch.jpg",
    "images/Hoodie.jpg",
    "images/jorden.jpg",
    "images/Kapuchi.jpg",
    "images/SneakerSHOES.jpg",
    "images/Sweatshirt.jpg"
  ];

  int index = 0;

  timming() async {
    await Future.delayed(Duration(seconds: 3));
    index = await images.length;
  setState(() {
    
  });
    index = index - 1;
    if (index == 0) {
      index = images.length;
    }
    print(images[index]);
    timming();
  }

  @override
  Widget build(BuildContext context) {
    timming();
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
                "products",
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
      body: Builder(builder: (context) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                    
                  Container(
                    
                    child: Image(
                      
                      image: AssetImage(
                        
                        "${images[index]}")),
                  ),
                  //second section
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 4,
                                mainAxisExtent: 330),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) => Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.only(right: 7),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade600,
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 5),
                                            ),
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(-5, 0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16)),
                                            child: Image(
                                                height: 170,
                                                width: 190,
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    "images/${snapshot.data!.docs[index]['image']}")),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                    snapshot.data!.docs[index]
                                                        ["name"],
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 4, 47, 83))),
                                                Text("Price: \$" +
                                                    snapshot.data!
                                                        .docs[index]["price"]
                                                        .toString()),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => Detials(
                                                                        currentEmail:
                                                                            widget
                                                                                .currentEmail,
                                                                        product: snapshot
                                                                            .data!
                                                                            .docs[index])));
                                                          },
                                                          child:
                                                              Text("buy now")),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ))),
                  ),
                ],
              );
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
        );
      }),
    );
  }
}
