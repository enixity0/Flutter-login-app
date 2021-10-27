import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Helper {
  storeLogin(userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userID", userID);
  }

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = prefs.getString("userID");
    print("ok");
    if (key == null) {
      return false;
    } else {
      return true;
    }
  }

  getLogin(String username, String password) async {
    var bodies = {"username": username, "password": password};
    final response = await http.post(
      "http://10.0.2.2:5000/login/",
      body: bodies,
    );
    String body = utf8.decode(response.bodyBytes);
    final Map data = jsonDecode(body);
    return data;
  }

  register(String username, String password) async {
    var bodies = {"username": username, "password": password};
    final response = await http.post(
      "http://10.0.2.2:5000/register/",
      body: bodies,
    );
    String body = utf8.decode(response.bodyBytes);
    final Map data = jsonDecode(body);
    return data;
  }
}
