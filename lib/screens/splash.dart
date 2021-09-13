import 'package:flutter/material.dart';

import 'home.dart';
import '../logged_out/auth_screen.dart';


class SplashScreen extends StatelessWidget {

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );

  void _navigateToAuthScreen(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(AuthScreen.route),
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(HomeScreen.route),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    _navigateToAuthScreen(context);

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}
