import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skripsi/home.dart';
import 'file:///C:/Users/wangs/AndroidStudioProjects/skripsi/lib/login_screen/background.dart';
import 'package:skripsi/components/rounded_input_field.dart';
import 'package:skripsi/components/rounded_password.dart';
import '../components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';

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
    var url = "http://192.168.42.191/prediksi/login_admin.php";
    setState(() {
      showSpinner = true;
    });
    var response = await http.post(url, body: {
      "username": emailControl.text,
      "password": passControl.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      Fluttertoast.showToast(
        msg: "Username & Password Incorrect!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
                  hintText: 'Email',
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

