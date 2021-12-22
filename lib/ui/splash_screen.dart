import 'dart:async';

import 'package:ecommerceweb/ui/Signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/AppColor.dart';
// import 'Signup_page.dart';
// // import 'LoginScreen.dart';
// // import 'package:fluttertoast/fluttertoast.dart';

// class Splash_screen extends StatefulWidget {
//   _Splash_screenState createState() => _Splash_screenState();
// }

// class _Splash_screenState extends State<Splash_screen> {
//   void initState() {
//     Timer(Duration(seconds: 3), () => Navigator.push(context, CupertinoPageRoute(builder: (_) => Signup_page())));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       builder: () => Scaffold(
//         backgroundColor: AppColor.dblue,
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "KI- LAGBA",
//                   style: TextStyle(color: Colors.white, fontSize: 44.sp, fontWeight: FontWeight.bold),
//                 ), //Text
//                 SizedBox(height: 20.h),
//                 CircularProgressIndicator(color: Colors.white),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // ScreenUtilInit(
// //       designSize: Size(375, 812),
// //       builder: () =>

class First_sc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        home: Splash_screen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Splash_screen extends StatefulWidget {
  _Splash_screenState createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  void initState() {
    Timer(Duration(seconds: 3), () => Navigator.push(context, CupertinoPageRoute(builder: (_) => Signup_page())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dblue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "KI-LAGBA",
                style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold),
              ), //Text
              SizedBox(height: 20),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
