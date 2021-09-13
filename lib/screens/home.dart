import 'package:flutter/material.dart';

import '../logged_out/auth_screen.dart';

class HomeScreen extends StatelessWidget {

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => HomeScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signed in'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            context.signOut();
            Navigator.of(context).push(AuthScreen.route);
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
