import 'package:blogging_app/auth/signin_screen.dart';
import 'package:blogging_app/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './route.dart';
import 'home/home_screen.dart';
import 'package:provider/provider.dart';
import './models/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CreateUser(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'blogging app',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // initialRoute: HomeScreen.routeName,
        home: Switch_Screens(),
        routes: routes,
      ),
    );
  }
}

class Switch_Screens extends StatelessWidget {
  Switch_Screens({Key? key}) : super(key: key);
  bool isloggedin = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("something went wrong"));
        }
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return isloggedin ? Signup_Screen() : Signin_Screen();
        }
      },
    );
  }
}
