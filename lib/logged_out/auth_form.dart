// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class AuthForm extends StatefulWidget {
//   const AuthForm(this.submitFn, this.isLoading);

//   final bool isLoading;
//   final void Function(
//     String email,
//     String password,
//     String username,
//     String accType,
//     bool isLogin,
//   ) submitFn;

//   @override
//   _AuthFormState createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm> {

//   final _formKey = GlobalKey<FormState>();
//   var acctype = "Student";

//   var _userEmail = "";
//   var _userName = "";
//   var _userPassword = "";
//   var _isLogin = true;

//   void _trySubmit() {
//     final isValid = _formKey.currentState!.validate();
//     FocusScope.of(context).unfocus();

//     if (isValid) {
//       _formKey.currentState!.save();
//       widget.submitFn(
//           _userEmail.trim(), _userPassword, _userName, acctype, _isLogin);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Center(
//         child: Card(
//           margin: EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     if (!_isLogin)
//                       DropdownButton(
//                         isExpanded: true,
//                         value: acctype,
//                         dropdownColor: Colors.white,
//                         elevation: 16,
//                         style: const TextStyle(
//                           color: Colors.black,
//                         ),
//                         underline: Container(
//                           height: 1,
//                           color: Colors.grey,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             acctype = newValue!;
//                           });
//                         },
//                         items: <String>['Student', 'Teacher']
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     TextFormField(
//                       key: ValueKey('email'),
//                       validator: (val) {
//                         if (val!.isEmpty || !val.contains('@')) {
//                           return 'Invalid email';
//                         }
//                         return null;
//                       },
//                       onSaved: (val) {
//                         _userEmail = val!;
//                       },
//                       keyboardType: TextInputType.emailAddress,
//                       // decoration: registerInputDecoration(hintText: 'Your email'),
//                       decoration: InputDecoration(labelText: 'Your email'),
//                     ),
//                     if (!_isLogin)
//                       TextFormField(
//                         key: ValueKey('username'),
//                         validator: (val) {
//                           if (val!.isEmpty) {
//                             return 'Name can\'t be null';
//                           }
//                           return null;
//                         },
//                         onSaved: (val) {
//                           _userName = val!;
//                         },
//                         // decoration: registerInputDecoration(hintText: 'Create username')
//                         decoration: InputDecoration(labelText: 'Your name'),
//                       ),
//                     TextFormField(
//                       key: ValueKey('password'),
//                       // decoration: registerInputDecoration(hintText: 'Create password'),
//                       validator: (val) {
//                         if (val!.isEmpty || val.length < 5) {
//                           return 'Password too short';
//                         }
//                         return null;
//                       },
//                       onSaved: (val) {
//                         _userPassword = val!;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Create password',
//                       ),
//                       obscureText: true,
//                     ),
//                     SizedBox(
//                       height: 12,
//                     ),
//                     if(widget.isLoading) CircularProgressIndicator(),
//                     if(!widget.isLoading)
//                     ElevatedButton(
//                       onPressed: _trySubmit,
//                       child: Text(_isLogin ? 'Sign In' : 'Sign Up'),
//                     ),
//                     TextButton(
//                       child: Text(_isLogin ? 'Sign Up' : 'Sign In'),
//                       onPressed: () => setState(() {
//                         _isLogin = !_isLogin;
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:final_task/classes/account.dart';
import 'package:final_task/shared/formatting.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final ValueChanged<bool> updateTitle;
  Login(this.updateTitle);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final User _account = User();
  final _formKey = GlobalKey<FormState>();


  String _email;
  String _pass;
  String _error = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context){
    return loginForm();
  }

  Widget loginForm(){
    return _loading ? AuthLoading(185, 20) : Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 45, 0, 5),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color: Color.fromRGBO(51, 204, 255, 0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    )],
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                        ),
                        child: TextFormField(
                          decoration: authInputFormatting.copyWith(hintText: "Enter Email"),
                          validator: _account.validateId,
                          onChanged: (val){
                            _email = val;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                        ),
                        child: TextFormField(
                          decoration: authInputFormatting.copyWith(hintText: "Enter Password"),
                          validator: _account.validateLoginPass,
                          obscureText: true,
                          onChanged: (val){
                            _pass = val;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text(_error, style: TextStyle(color: Colors.red),),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () async{
                    if(_formKey.currentState.validate())
                    {
                      setState(() => _loading = true);
                      FirebaseUser user = await _account.login(_email, _pass);
                      if(user != null)
                      {
                        bool isEmailVerified = user.emailVerified;
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
                        }
                      }
                      else
                      {
                        setState(() {
                          _loading = false;
                          _error = 'Email and/or password is incorrect';
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.cyan,
                    ),
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 17),),
                    ),
                  ),
                ),
                SizedBox(height : 30),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => widget.updateTitle(false),
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.cyan[300],
            ),
            child: Center(
              child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 17),),
            ),
          ),
        ),
      ],
    );
  }
}
