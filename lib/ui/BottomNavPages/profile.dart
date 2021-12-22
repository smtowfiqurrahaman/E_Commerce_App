import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../const/AppColor.dart';

class Profile extends StatefulWidget {
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _phoneController;
  TextEditingController? _genderController;
  TextEditingController? _dobController;

  setDataToTextfield(data) {
    return Column(
      children: [
        SizedBox(height: 15.h),
        Center(
          child: Container(
            height: 200,
            width: 200,
            child: Image(
              image: NetworkImage("https://avatars.githubusercontent.com/u/62378943?v=4"),
            ),
            // color: AppColor.dblue,
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(100)),
          ),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          decoration: InputDecoration(
            icon: CircleAvatar(child: Icon(Icons.person)),
            hintText: "Name",
            labelText: "Name",
          ),
          controller: _nameController = TextEditingController(text: data["name"]),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          decoration: InputDecoration(
            icon: CircleAvatar(child: Icon(Icons.filter_vintage)),
            hintText: "Age",
            labelText: "Age",
          ),
          controller: _ageController = TextEditingController(text: data["age"]),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          decoration: InputDecoration(
            icon: CircleAvatar(child: Icon(Icons.phone_iphone)),
            hintText: "Phone",
            labelText: "Phone",
          ),
          controller: _phoneController = TextEditingController(text: data["phone"]),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          decoration: InputDecoration(
            icon: CircleAvatar(
              child: Icon(Icons.admin_panel_settings),
            ),
            hintText: "Gender",
            labelText: "Gender",
          ),
          controller: _genderController = TextEditingController(text: data["gender"]),
        ),
        SizedBox(height: 15.h),
        TextFormField(
          decoration: InputDecoration(
            icon: CircleAvatar(child: Icon(Icons.calendar_today)),
            hintText: "Date Of Birth",
            labelText: "Date Of Birth",
          ),
          controller: _dobController = TextEditingController(text: data["dob"]),
        ),
        SizedBox(height: 20.h),
        Container(
          width: 1.sw,
          height: 56.w,
          child: ElevatedButton(
            onPressed: () => updateData(),
            child: Text(
              "Submit",
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
        SizedBox(height: 5.h),
      ],
    );
  }

  updateData() {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "age": _ageController!.text,
      "phone": _phoneController!.text,
      "gender": _genderController!.text,
      "dob": _dobController!.text,
    }).then((value) => Fluttertoast.showToast(msg: "Updated Sucessfully....."));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users-form-data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var data = snapshot.data;
                  if (data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return setDataToTextfield(data);
                },
              ),
            ),
          ),
        ), //safearea
      ), //Scaffold
    );
  }
}
