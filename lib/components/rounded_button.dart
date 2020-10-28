import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final color, textColor;
  const RoundedButton({
    this.color,
    this.press,
    this.text,
    this.textColor = Colors.white,
  }) ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 20),
          color: Colors.teal[200],
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}