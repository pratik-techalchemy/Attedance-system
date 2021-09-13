import 'package:final_task/logged_out/authentication.dart';
import 'package:final_task/classes/palette.dart';
import 'package:final_task/logged_out/methods/sign_in_up_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_task/screens/title.dart';
import 'package:final_task/classes/decoration_functions.dart';
import 'package:provider/src/provider.dart';

import '../../screens/home.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onRegisterClicked;
  SignIn(this.onRegisterClicked);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  String _email;
  String _pass;
  String _error = '';
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  void _navigateToHomeScreen(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => Navigator.of(context).pushReplacement(HomeScreen.route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Welcome\nBack',
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      decoration: signInInputDecoration(hintText: 'Email'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: TextFormField(
                      decoration: signInInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignInBar(
                    label: 'Sign in',
                    isLoading: true,
                    onPressed: () async{
                    if(_formKey.currentState.validate())
                    {
                      setState(() => _loading = true);
                      FirebaseUser user = await _account.login(_email, _pass);
                      if(user != null)
                      {
                        bool isEmailVerified = user.isEmailVerified;
                        dynamic type = await UserDataBase(user).userType();
                        if(type != null){
                          Navigator.of(context).pushReplacementNamed('/home', arguments: {'type' : type, 'isEmailVerified' : isEmailVerified});
                        }
                        else{
                          await _account.signOut();
                          setState(() {
                            _loading = false;
                            _error = 'Couldn\'t get user type, try again';
                          });
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onRegisterClicked.call();
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Palette.darkBlue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
