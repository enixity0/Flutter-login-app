import 'package:flutter/material.dart';

import './colors.dart';

import './screens/home.dart';
import './screens/signin.dart';
import 'functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final helper = Helper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freelancing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: generateMaterialColor(Palette.background),
        accentColor: generateMaterialColor(Palette.main),
        brightness: Brightness.light,
        accentColorBrightness: Brightness.dark,
        buttonColor: generateMaterialColor(Palette.main),
        errorColor: Colors.red,
      ),
      home: FutureBuilder<bool>(
        future: helper.checkLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == false) {
            return SignIn();
          } else {
            return Home();
          }
        },
      ),
    );
  }
}
