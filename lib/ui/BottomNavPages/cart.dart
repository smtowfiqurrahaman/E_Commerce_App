import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/AppColor.dart';

class Cart extends StatefulWidget {
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Something Is Wrong"));
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Text(_documentSnapshot["name"]),
                          title: Text("\$ ${_documentSnapshot["price"]}", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.dblue)),
                          trailing: GestureDetector(
                            child: CircleAvatar(
                              child: Icon(Icons.remove_circle),
                            ),
                            onTap: () {
                              FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentSnapshot.id).delete();
                            },
                          ),
                        ),
                      );
                    });
              } // StreamBuilder
              ), // SafeArea
        ),
      ),
    );
  }
}
