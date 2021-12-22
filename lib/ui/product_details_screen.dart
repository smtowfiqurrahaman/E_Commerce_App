import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../const/AppColor.dart';
import 'BottomNavPages/cart.dart';

class Product_details extends StatefulWidget {
  var _product;
  Product_details(this._product);
  @override
  _Product_detailsState createState() => _Product_detailsState();
}

class _Product_detailsState extends State<Product_details> {
  //Add To Cart Function
  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users-cart-items");
    return collectionReference.doc(currentUser!.email).collection("items").doc().set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(msg: "Add To Cart.."));
  } //Add To Cart Function

  //Add To Favourite Function
  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("users-favourite-items");
    return collectionReference.doc(currentUser!.email).collection("items").doc().set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(msg: "Add To Favourite.."));
  } //Add To Favourite Function

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColor.dblue,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          actions: [
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").where("name", isEqualTo: widget._product["product-name"]).snapshots(),
                builder: (BuildContext, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Text("");
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      backgroundColor: AppColor.dblue,
                      child: IconButton(
                          onPressed: () => snapshot.data.docs.length == 0 ? addToFavourite() : print(Fluttertoast.showToast(msg: "Updated Sucessfully.....")),
                          icon: snapshot.data.docs.length == 0
                              ? Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                    ),
                  );
                }),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(left: 20.sp, top: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Image.network(
                    widget._product["product-img"],
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    widget._product["product-name"],
                    style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5.h),

                  Text(
                    widget._product["product-price"].toString(),
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      widget._product["product-discription"],
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  //Button Add To Cart------------------------------------------------------
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Container(
                      width: 1.sw,
                      height: 56.w,
                      child: ElevatedButton(
                        onPressed: () => addToCart(),
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: AppColor.dblue,
                          elevation: 3,
                        ),
                      ),
                    ),
                  ), //Padding
                  SizedBox(height: 60.h),
                ], //Children
              ),
            ),
          ), //column
        ), //safearea
      ),
    );
  }
}
