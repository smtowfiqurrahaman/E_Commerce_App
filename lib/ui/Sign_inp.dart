import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../const/AppColor.dart';
import 'Sign_inp.dart';
import 'Signup_page.dart';
import 'bottom_nav_controller.dart';
import 'splash_screen.dart';

class Signin_page extends StatefulWidget {
  _Signin_pageState createState() => _Signin_pageState();
}

class _Signin_pageState extends State<Signin_page> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

// firebase authothincation Code
  signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      var authCreadential = userCredential.user;
      print(authCreadential!.uid);
      if (authCreadential.uid.isNotEmpty) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => BottomNavController()));
      } else {
        Fluttertoast.showToast(msg: "Something is Worng");
      }

      //new code
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        backgroundColor: AppColor.dblue,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 150.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home, color: Colors.transparent),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(fontSize: 25.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ), //containercal End 1
              Expanded(
                flex: 3,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50.h),
                          Text(
                            "Welcome Buddy",
                            style: TextStyle(
                              fontSize: 25.sp,
                              color: AppColor.dblue,
                            ),
                          ),
                          Text(
                            "Glad To see you",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                width: 41.w,
                                decoration: BoxDecoration(
                                  color: AppColor.dblue,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.email_rounded,
                                    size: 25.w,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ), // ICon Gmaillllll
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 30, 10),
                                  child: TextField(
                                    controller: _emailController,
                                    // obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      hintText: "yourGmail@gmail.com",
                                      hintStyle: TextStyle(
                                        fontSize: 18.sp,
                                        color: Color(0xff414041),
                                      ),
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                        fontSize: 20.sp,
                                        color: AppColor.dblue,
                                      ),
                                    ),
                                  ),
                                ),
                              ), //Expended 2
                            ],
                          ), //Row 1 Email
                          SizedBox(height: 10.sp),
                          Row(
                            children: [
                              Container(
                                height: 48.h,
                                width: 41.w,
                                decoration: BoxDecoration(
                                  color: AppColor.dblue,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.lock_outline,
                                    size: 25.w,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ), // ICon Gmaillllll
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 30, 10),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      hintText: "Password must be 6 carecter",
                                      hintStyle: TextStyle(
                                        fontSize: 18.sp,
                                        color: Color(0xff414041),
                                      ),
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        fontSize: 20.sp,
                                        color: AppColor.dblue,
                                      ),
                                      suffixIcon: _obscureText == true
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = false;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                size: 20.w,
                                              ))
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _obscureText = true;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.visibility_off,
                                                size: 20.w,
                                              ),
                                            ),
                                    ),
                                  ),
                                ), //Expended 2
                              )
                            ],
                          ), //Row 2 Email
                          SizedBox(height: 50.h),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Container(
                              width: 1.sw,
                              height: 56.w,
                              child: ElevatedButton(
                                onPressed: () {
                                  signIn();
                                },
                                child: Text(
                                  "Sign In",
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
                          ), //Container
                          SizedBox(height: 20.h),
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  "Don't have an account?  ",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFBBBBBB),
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.dblue,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (_) => Signup_page()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ], //Children
                      ),
                    ),
                  ), //Padding
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
