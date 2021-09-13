import 'package:flutter/material.dart';

import '../logged_out/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

// import 'package:final_task/screens/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:final_task/logged_out/methods/sign_in.dart';
// import 'package:final_task/logged_out/methods/register.dart';
// import 'package:flutter/foundation.dart';

// import '../classes/background_painter.dart';

class AuthScreen extends StatefulWidget {
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (_) => AuthScreen(),
      );

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //   with SingleTickerProviderStateMixin {
  // late AnimationController _controller;

  // ValueNotifier<bool> showSigninPage = new ValueNotifier<bool>(true);

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 2),
  //   );
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _controller.dispose();
  //   super.dispose();
  // }
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(String email, String password, String username,
      String accType, bool isLogin) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });

      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (accType == 'Student') {
          FirebaseFirestore.instance
              .collection('Student')
              .doc(authResult.user.uid)
              .set({'username': username, 'email': email});
        } else {
          FirebaseFirestore.instance
              .collection('Teacher')
              .doc(authResult.user.uid)
              .set({
            'username': username,
            'email': email,
            'tid': authResult.user.uid
          });
        }
      }
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials';

      if (err.message != null) {
        message = err.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return FirebaseAuth.instance.authStateChanges.listen(
    //   onAuthSucess: () {
    //     Navigator.of(context).pushReplacement(HomeScreen.route);
    //   },
    //   child: Scaffold(
    //     body: Stack(
    //       children: <Widget>[
    //         SizedBox.expand(
    //           child: CustomPaint(
    //             painter: BackgroundPainter(animation: _controller.view),
    //           ),
    //         ),
    //         ValueListenableBuilder<bool>(
    //           valueListenable: showSigninPage,
    //           builder: (context, value, child) {
    //             return value
    //                 ? SignIn(onRegisterClicked: () {
    //                     context.resetSignInForm();
    //                     showSigninPage.value = false;
    //                     _controller.forward();
    //                   })
    //                 : Register(
    //                     onSignInPressed: () {
    //                       context.resetSignInForm();
    //                       showSigninPage.value = true;
    //                       _controller.reverse();
    //                     },
    //                   );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return AuthForm(_submitAuthForm, _isLoading);
  }
}
