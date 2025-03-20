import "package:flutter/material.dart";
import "package:frontend/controllers/theme_controller.dart";
import "package:provider/provider.dart";
import "package:frontend/pages/login_page.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeControl(),
      child: Builder(
        builder: (context) {
          final themeControl = Provider.of<ThemeControl>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeControl.themeData,
            initialRoute: '/',
            routes: {
              '/': (context) => LoginPage(),
              //
              //
            },
          );
        },
      ),
    );
  }
}
