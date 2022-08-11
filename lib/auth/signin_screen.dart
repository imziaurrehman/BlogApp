import 'package:blogging_app/auth/signup_screen.dart';
import 'package:blogging_app/customs.dart';
import 'package:blogging_app/models/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:email_validator/email_validator.dart';

class Signin_Screen extends StatefulWidget {
  Signin_Screen({Key? key}) : super(key: key);
  static const routeName = "signin";

  @override
  State<Signin_Screen> createState() => _Signin_ScreenState();
}

class _Signin_ScreenState extends State<Signin_Screen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  final currentuser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void showtoast() => Fluttertoast.showToast(
        msg: "${currentuser!.email.toString()} Is Successfully LoggedIn",
        backgroundColor: Color.fromARGB(221, 154, 66, 170),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<CreateUser>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Signin Screen",
          style: TextStyle(color: Color.fromARGB(221, 154, 66, 170)),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme:
            const IconThemeData(color: Color.fromARGB(221, 154, 66, 170)),
      ),
      body: GestureDetector(
        onDoubleTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  login_title(context),
                  const SizedBox(
                    height: 60,
                  ),
                  _buildEmailfield(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildPasswordfield(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(onPressed: () {}, child: Text("Forgot Password?")),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => user
                        .login(
                            email: emailcontroller.text,
                            password: passwordcontroller.text)
                        .then((_) {
                      setState(() {
                        showtoast();
                      });
                    }),
                    child: Text("Login", textScaleFactor: 1.09),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.4,
                            vertical: size.height * 0.018)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("if user are not signedIn,then please"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Signup_Screen.routeName);
                          },
                          child: const Text("SignUP?")),
                      const Text("here\t."),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container login_title(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: size.height * 0.05),
      child: Text(
        "Login",
        style: title,
      ),
    );
  }

  TextFormField _buildEmailfield() {
    return TextFormField(
      controller: emailcontroller,
      decoration: InputDecoration(
          hintText: "Enter Email Here",
          label: const Text("Email"),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), gapPadding: 6),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          prefixIcon: const Icon(Icons.email_outlined)),
      keyboardType: TextInputType.emailAddress,
      maxLength: 20,
      maxLines: 1,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField _buildPasswordfield() {
    return TextFormField(
      controller: passwordcontroller,
      decoration: InputDecoration(
          hintText: "Enter Password Here",
          label: const Text("Password"),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20), gapPadding: 6),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          prefixIcon: const Icon(Icons.password_outlined)),
      keyboardType: TextInputType.visiblePassword,
      maxLength: 20,
      maxLines: 1,
      textInputAction: TextInputAction.done,
    );
  }
}
