import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../const/AppColor.dart';

class Searchscreen extends StatefulWidget {
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) {
                    setState(() {
                      inputText = val;
                      print(inputText);
                    });
                  },
                  // controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.blue),
                    ), //focused Border
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ), //Enebled Border
                    hintText: "Search Product Here", //Hint Text
                    hintStyle: TextStyle(fontSize: 15), //Hint Style
                  ),
                ), // Text Field
                SizedBox(height: 20.h),
                Expanded(
                  // child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("products").snapshots(),
                    // .where("product-name", isEqualTo: inputText)
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Something is Worng"));
                        // Fluttertoast.showToast(msg: "Something is Worng");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Text(
                          "Loading.....",
                          style: TextStyle(fontSize: 25.sp, color: AppColor.dblue),
                        ));
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(data["product-name"]),
                              subtitle: Text(data["product-price"].toString()),
                              // subtitle: Text(data["p-discription"]),
                              leading: Image.network(data["product-img"]),
                              trailing: Icon(Icons.favorite_border),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ], //children
            ),
          ), //Padding
        ),
      ),
    );
  }
}
