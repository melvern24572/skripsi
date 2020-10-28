
import 'package:flutter/material.dart';
import 'components/routes.dart';
import 'drawer_profile.dart';


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerProfile(
            images:
                'https://upload.wikimedia.org/wikipedia/commons/b/be/Pygoscelis_papua.jpg',
            text: 'Penguin',
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => Navigator.pushReplacementNamed(context, Routes.home),
          ),
          ListTile(
              leading: Icon(Icons.show_chart),
              title: Text(
                'Prediction',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () => Navigator.pushReplacementNamed(context, Routes.prediksi)),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
