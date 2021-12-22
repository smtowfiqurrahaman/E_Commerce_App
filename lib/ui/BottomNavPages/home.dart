import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/AppColor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../product_details_screen.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Functions
  List<String> _carosulImages = [];
  List _products = [];
  var _dotPosition = 0;
  var _fireStoreInstance = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();

  //Carsoul Images from firebase
  fetchCarouselImages() async {
    QuerySnapshot qn = await _fireStoreInstance.collection("carosul-images").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carosulImages.add(
          qn.docs[i]["images"],
        );
      }
    });
    return qn.docs;
  } //firebase img collection

  fetchProducts() async {
    QuerySnapshot qn = await _fireStoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-discription": qn.docs[i]["product-discription"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });
    return qn.docs;
  } //Products Fecth from firebase

//page load Both work
  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }
//page load Both work

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                //Firebase
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: CarouselSlider(
                    items: _carosulImages
                        .map((item) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      initialPage: 0,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (val, CarouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                          ;
                        });
                      },
                    ),
                  ),
                ), //Firebase Carousel
                DotsIndicator(
                  dotsCount: _carosulImages.length == 0 ? 1 : _carosulImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColor.dblue,
                    spacing: EdgeInsets.all(2),
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                ), //Dot Indecator
                SizedBox(height: 20.h), //Sizedbox
                // Productsss Start
                Expanded(
                  child: GridView.builder(
                      // scrollDirection: Axis.vertical,
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Product_details(_products[index]))),
                          child: Card(
                            child: Column(
                              children: [
                                Image.network(
                                  _products[index]["product-img"],
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Text("${_products[index]["product-name"]}"),
                                Text("${_products[index]["product-price"].toString()}"),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ), //column
          ),
        ),
      ),
    );
  }
}
