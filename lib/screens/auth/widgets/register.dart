import 'package:final_task/config/palette.dart';
import 'package:flutter/material.dart';

import 'package:final_task/screens/auth/title.dart';
import 'package:final_task/screens/auth/sign_in_up_bar.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'decoration_functions.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.onSignInPressed}) : super(key: key);

  final VoidCallback onSignInPressed;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String dropdownValue = 'Student';

  @override
  Widget build(BuildContext context) {
    final isSubmitting = context.isSubmitting();
    
    return SignInForm(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: LoginTitle(
                  title: 'Create\nAccount',
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: DropdownButton(
                      isExpanded: true,
                      iconEnabledColor: Palette.darkBlue,
                      value: dropdownValue,
                      dropdownColor: Palette.darkBlue,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Mulish',
                      ),
                      underline: Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Student', 'Teacher']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: registerInputDecoration(hintText: 'First name'),
                            ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(''),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                              ),
                            decoration: registerInputDecoration(hintText: 'Last name'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: EmailTextFormField(
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: registerInputDecoration(hintText: 'Email')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: PasswordTextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration: registerInputDecoration(hintText: 'Password'),
                    ),
                  ),
                  SignUpBar(
                    label: 'Sign up',
                    isLoading: isSubmitting,
                    onPressed: () {
                      context.registerWithEmailAndPassword();
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        widget.onSignInPressed.call();
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
