import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skripsi/home.dart';
import 'package:skripsi/utils/function.dart';
import './background.dart';
import 'package:skripsi/components/rounded_input_field.dart';
import 'package:skripsi/components/rounded_password.dart';
import '../components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:skripsi/components/constrant.dart' as constrant;
class BodyPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<BodyPage> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passControl = new TextEditingController();
  bool showSpinner = false;
  String email;
  String password;

  Future login() async {
    var url = "${constrant.url}/login_admin.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "username": emailControl.text,
      "password": passControl.text,
    }).timeout(const Duration(seconds: 5));
    var data = json.decode(response.body);

    Functions.toast(msg: data == "Success" ? "Login Successful" : "Username & Password Incorrect!!");
    if (data == "Success") Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SafeArea(
                  child: Image(
                    image: AssetImage('images/login.png'),
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedInputField(
                  controller: emailControl,
                  hintText: 'Username',
                ),
                RoundedPassword(
                  control: passControl,
                ),
                RoundedButton(
                  text: 'LOGIN',
                  press: () async {
                    login();
                  },
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

