import 'package:blogging_app/auth/signin_screen.dart';
import 'package:blogging_app/auth/signup_screen.dart';
import 'package:blogging_app/home/create_post.dart';
import 'package:blogging_app/home/post_listview.dart';
import 'package:flutter/material.dart';
import 'home/home_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  Create_Post.routeName: (context) => Create_Post(),
  Signin_Screen.routeName: (context) => Signin_Screen(),
  Signup_Screen.routeName: (context) => Signup_Screen(),
  Postlistview.routeName: (context) => Postlistview(),
};
