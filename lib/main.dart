import 'package:flutter/material.dart';
import 'package:skripsi/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './components/routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(context),
      initialRoute: LoginScreen.routeName,
      /*theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),*/
    );
  }
}
