import 'package:final_task/screens/auth/home.dart';
import 'package:flutter/material.dart';

import 'package:final_task/screens/auth/sign_in.dart';
import 'package:final_task/screens/auth/widgets/register.dart';
import 'package:flutter/foundation.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import '../../screens/background_painter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (_) => AuthScreen(),
      );

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ValueNotifier<bool> showSigninPage = new ValueNotifier<bool>(true);

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LitAuth.custom(
      onAuthSuccess: () {
        Navigator.of(context).pushReplacement(HomeScreen.route);
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(animation: _controller.view),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: showSigninPage,
              builder: (context, value, child) {
                return value
                    ? SignIn(onRegisterClicked: () {
                        context.resetSignInForm();
                        showSigninPage.value = false;
                        _controller.forward();
                      })
                    : Register(
                        onSignInPressed: () {
                          context.resetSignInForm();
                          showSigninPage.value = true;
                          _controller.reverse();
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
