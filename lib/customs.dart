import 'package:flutter/material.dart';
import 'dart:io';

TextStyle title = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: Color.fromARGB(221, 154, 66, 170),
);

class MyUtility {
  BuildContext context;

  MyUtility(this.context) : assert(context != null);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}

File? pickedimage;
//
String? name;
File? getimage;

// signup email and username

TextEditingController username = TextEditingController();

// Container image_picker_container(BuildContext context, Widget child) {
//    Size size = MediaQuery.of(context).size;
//   return Container(
//     margin: EdgeInsets.only(left: 66),
//     child: child,
//     width: size.width * 0.6,
//     height: size.height * 0.25,
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey, width: 2),
//       color: Colors.white,
//     ),
//   );
// }
String netimg =
    "https://www.google.com/search?q=user+icon&oq=user+icon&aqs=edge..69i57j0i512l2j0i67j0i512l4j69i64.11035j0j9&sourceid=chrome&ie=UTF-8#imgrc=if5Xjfzz50DEwM";
