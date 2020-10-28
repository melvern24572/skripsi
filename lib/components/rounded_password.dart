import 'package:flutter/material.dart';
import 'text_field_container.dart';

class RoundedPassword extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController control;
  RoundedPassword({this.onChanged, this.control, });
  @override
  _RoundedPasswordState createState() => _RoundedPasswordState();
}

class _RoundedPasswordState extends State<RoundedPassword> {
  bool obscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child:  TextField(
        controller: (widget.control),
        obscureText: obscured,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
            onPressed: (){
              setState(() {
               obscured = !obscured;
              });
            },
          ) ,
          border: InputBorder.none,
        ),
      ),
    );

  }
}


