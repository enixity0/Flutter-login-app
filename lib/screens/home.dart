import 'package:flutter/material.dart';
import 'package:login_gaming_app/screens/signin.dart';
import 'package:login_gaming_app/widgets/normal_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Logged in, you can't get out.");
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Logged In!"),
              AppButton(
                color: Palette.accent,
                text: "Logout",
                border: BorderRadius.circular(22),
                pressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("userID");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
