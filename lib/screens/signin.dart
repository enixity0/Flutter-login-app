import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_gaming_app/screens/home.dart';
import 'package:login_gaming_app/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../functions.dart';
import '../widgets/normal_button.dart';
import './signup.dart';
import 'package:dio/dio.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String passwordErrorMessage = "";

  String usernameErrorMessage = "";

  String serverMessage = "";
  Color serverMessageColor = Colors.black;
  bool _loginLoading = false;

  void validateUsername() {
    setState(() {
      usernameErrorMessage = "";
    });
    final String username = _usernameController.text;
    bool hasSpaces = username.contains(" ");
    bool hasDigits = username.contains(new RegExp(r'[0-9]'));
    bool hasUppercase = username.contains(new RegExp(r'[A-Z]'));
    bool hasLowercase = username.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        username.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = username.length > 4;
    if (hasSpaces == true) {
      setState(() {
        usernameErrorMessage += "\n Username can't contain white spaces";
      });
    }
    if (hasDigits != true && hasMinLength != true) {
      setState(() {
        usernameErrorMessage +=
            "\n Username can't be empty and requires 8 Digits";
      });
    }
    if (hasLowercase != true || hasUppercase == true) {
      setState(() {
        usernameErrorMessage += "\n Username requires lower case only";
      });
    }
    if (hasSpecialCharacters == true) {
      setState(() {
        usernameErrorMessage += "\n Username can't contain special characters";
      });
    }
  }

  void validatePassword() {
    setState(() {
      passwordErrorMessage = "";
    });
    final String password = _passwordController.text;
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasSpaces = password.contains(" ");
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length > 8;
    if (hasSpaces == true) {
      setState(() {
        usernameErrorMessage += "\n Password can't contain white spaces";
      });
    }
    if (hasDigits != true && hasMinLength != true) {
      setState(() {
        passwordErrorMessage +=
            "\n Password can't be empty and 8 requires Digits";
      });
    }
    if (hasUppercase != true && hasLowercase != true) {
      setState(() {
        passwordErrorMessage +=
            "\n Password requires Upper case and Lower case";
      });
    }
    if (hasSpecialCharacters != true) {
      setState(() {
        passwordErrorMessage += "\n Password requires special characters";
      });
    }
  }

  void validate() async {
    final helper = Helper();
    setState(() {
      _loginLoading = true;
    });
    validatePassword();
    validateUsername();
    if (passwordErrorMessage == "" && usernameErrorMessage == "") {
      final String password = _passwordController.text;
      final String username = _usernameController.text;
      final data = await helper.getLogin(username, password);
      print(data);
      if (data['error'] == 0) {
        setState(() {
          serverMessage = data['message'];
          helper.storeLogin(data['userID']);
          _loginLoading = false;
          serverMessageColor = Colors.green;
          sleep(new Duration(seconds: 5));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        });
      } else {
        serverMessage = data['message'];
        serverMessageColor = Palette.accent;
        _loginLoading = false;
      }
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Palette.background,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/bg-sign-in.jpg'),
                          ),
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.background,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22),
                                topRight: Radius.circular(22),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 50),
                                child: Text(
                                  "Welcome Back!",
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    color: Palette.title,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                  ),
                                ),
                              ),
                              Text(
                                serverMessage,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: serverMessageColor),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Text(
                            "Username",
                            style: GoogleFonts.getFont(
                              'Roboto',
                              color: Palette.title,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        CTextField(
                          controller: _usernameController,
                          error: usernameErrorMessage,
                          icon: usernameErrorMessage == ""
                              ? Icons.check_circle
                              : Icons.close,
                          placeholder: "@username",
                          type: "email",
                          onSubmit: (_) => {validate()},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Password",
                            style: GoogleFonts.getFont(
                              'Roboto',
                              color: Palette.title,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        CTextField(
                          controller: _passwordController,
                          error: passwordErrorMessage,
                          icon: passwordErrorMessage == ""
                              ? Icons.check_circle
                              : Icons.close,
                          placeholder: "********",
                          type: "password",
                          onSubmit: (_) => {validate()},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: size.height * 0.1),
                child: Column(
                  children: [
                    AppButton(
                      border: false,
                      color: Palette.main,
                      pressed: () => validate(),
                      text: "Login",
                      textColor: Colors.white,
                      loading: _loginLoading,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp())),
                          child: Text("Don't have an account? SignUp")),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
