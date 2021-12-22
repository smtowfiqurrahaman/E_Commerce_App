import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/AppColor.dart';

Widget customButton(String buttonText, onPressed) {
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 18.sp),
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColor.dblue,
        elevation: 3,
      ),
    ),
  );
  //  return Padding(
  //           padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
  //             child: Container(
  //               width: 1.sw,
  //               height: 56.w,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                  onPressed: onPressed,
  //                  },
  //                 child: Text(
  //                 "Sign In",
  //                   style: TextStyle(
  //                      color: Colors.white,
  //                       fontSize: 18.sp,
  //                                 ),
  //                               ),
  //                               style: ElevatedButton.styleFrom(
  //                                 primary: AppColor.dblue,
  //                                 elevation: 3,
  //                               ),
  //                             ),
  //                           ),
  //                         ), //Container
}
