import 'package:flutter/material.dart';


class DrawerProfile extends StatelessWidget {
  final String images;
  final String text;
  const DrawerProfile({
    Key key, @required this.images, @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(images),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}