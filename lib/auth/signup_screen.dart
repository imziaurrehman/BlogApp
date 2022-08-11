import 'package:blogging_app/customs.dart';
import 'package:blogging_app/models/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../customs.dart';
import 'package:email_validator/email_validator.dart';

class Signup_Screen extends StatefulWidget {
  Signup_Screen({Key? key}) : super(key: key);
  static const routeName = "signup";

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // username.dispose();
    // _confirmpassword.dispose();
    // username.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void showtoast() => Fluttertoast.showToast(
        msg: "Registeration Is Successfully Done",
        backgroundColor: Color.fromARGB(221, 154, 66, 170),
      );

  @override
  void initState() {
    print(username.text.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(username.text.toString());
    bool isloading = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Signup Screen",
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
                  _buildusernamefield(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildEmailfield(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildPasswordfield(),
                  const SizedBox(
                    height: 20,
                  ),
                  // _buildConfirmPasswordfield(),
                  const SizedBox(
                    height: 20,
                  ),
                  registerbutton(context, () async {
                    final user =
                        Provider.of<CreateUser>(context, listen: false);
                    await user
                        .registeration(
                            email: _email.text,
                            password: _password.text,
                            username: username.text)
                        .whenComplete(() {
                      showtoast();
                      Navigator.pop(context);
                    });
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox registerbutton(BuildContext context, VoidCallback onpress) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.0567,
      child: ElevatedButton(
        onPressed: onpress,
        child: const Text(
          "Register",
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.fade,
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
        "Registeration",
        style: title,
      ),
    );
  }

  TextFormField _buildusernamefield() {
    return TextFormField(
      controller: username,
      decoration: InputDecoration(
          hintText: "Enter username Here",
          label: const Text("username"),
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

  TextFormField _buildEmailfield() {
    return TextFormField(
      controller: _email,
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
      controller: _password,
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
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField _buildConfirmPasswordfield() {
    return TextFormField(
      controller: _confirmpassword,
      decoration: InputDecoration(
          hintText: "Enter Confirm Password Here",
          label: const Text("Confirm Password"),
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
