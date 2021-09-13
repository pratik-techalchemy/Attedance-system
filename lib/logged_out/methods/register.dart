// import 'package:flutter/material.dart';

// import 'package:final_task/classes/palette.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:final_task/screens/title.dart';
// import 'package:final_task/logged_out/methods/sign_in_up_bar.dart';

// import '../../classes/decoration_functions.dart';

// class Register extends StatefulWidget {
//   final VoidCallback onSignInPressed;

//   const Register({Key? key, required this.onSignInPressed}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   String? firstName, lastName, email, password, acType;
//   String dropdownValue = 'Student';

//   @override
//   Widget build(BuildContext context) {
//     final isSubmitting = context.isSubmitting();

//     return SignInForm(
//       child: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//             const Expanded(
//               flex: 2,
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: LoginTitle(
//                   title: 'Create\nAccount',
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 6,
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: DropdownButton(
//                       isExpanded: true,
//                       iconEnabledColor: Palette.darkBlue,
//                       value: dropdownValue,
//                       dropdownColor: Palette.darkBlue,
//                       elevation: 16,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontFamily: 'Mulish',
//                       ),
//                       underline: Container(
//                         height: 1,
//                         color: Colors.white,
//                       ),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           dropdownValue = newValue!;
//                           acType = newValue;
//                         });
//                       },
//                       items: <String>['Student', 'Teacher']
//                           .map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 5,
//                           child: TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                             decoration:
//                                 registerInputDecoration(hintText: 'First Name'),
//                             autocorrect: false,
//                             onChanged: (val) => firstName = val,
//                             validator: (val) =>
//                                 val!.isEmpty ? 'Can\'t Be Empty' : null,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(''),
//                         ),
//                         Expanded(
//                           flex: 5,
//                           child: TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                             decoration:
//                                 registerInputDecoration(hintText: 'Last Name'),
//                             autocorrect: false,
//                             onChanged: (val) => firstName = val,
//                             validator: (val) =>
//                                 val!.isEmpty ? 'Can\'t Be Empty' : null,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: EmailTextFormField(
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                       decoration: registerInputDecoration(hintText: 'Email'),

//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: PasswordTextFormField(
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                       decoration: registerInputDecoration(hintText: 'Password'),
//                     ),
//                   ),
//                   SignUpBar(
//                     label: 'Sign up',
//                     isLoading: isSubmitting,
//                     onPressed: () {
//                       context.registerWithEmailAndPassword();
//                     },
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: InkWell(
//                       splashColor: Colors.white,
//                       onTap: () {
//                         widget.onSignInPressed.call();
//                       },
//                       child: const Text(
//                         'Sign in',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:final_task/classes/account.dart';
import 'package:final_task/classes/firestore.dart';
import 'package:final_task/shared/formatting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final ValueChanged<bool> updateTitle;
  Register(this.updateTitle);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final User _account = User();
  final _formKey = GlobalKey<FormState>();

  String email, pass, firstName, lastName;
  String error = '';
  String type = '';
  List<String> _types = ['', 'Student', 'Teacher'];
  bool loading = false;
  Widget _currentForm;

  @override
  void initState() {
    super.initState();
    _currentForm = _registerNameEmail();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? AuthLoading(185, 20) : Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 45, 0, 5),
          child: _currentForm,
        ),
        SizedBox(height: 30,),
        GestureDetector(
          onTap: () => widget.updateTitle(true),
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.cyan[300],
            ),
            child: Center(
              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 17),),
            ),
          ),
        ),
      ],
    );
  }

  Widget _registerNameEmail(){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child:Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]))
                        ),
                        child: TextFormField(
                          decoration: authInputFormatting.copyWith(hintText: "First Name"),
                          validator: (val) => val.isEmpty ? 'Can\'t Be Empty' : null,
                          onChanged: (val){
                            firstName = val;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]))
                        ),
                        child: TextFormField(
                          decoration: authInputFormatting.copyWith(hintText: "Last Name"),
                          validator: (val) => val.isEmpty ? 'Can\'t Be Empty' : null,
                          onChanged: (val){
                            lastName =val;
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                  ),
                  child: TextFormField(
                    decoration: authInputFormatting.copyWith(hintText: "Enter Email"),
                    validator: _account.validateId,
                    onChanged: (val){
                      email = val;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text(error, style: TextStyle(color: Colors.red),),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: () {
              if(_formKey.currentState.validate())
                {
                  setState(() {
                    _currentForm = _registerPasswordType();
                  });
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
                child: Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 17),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerPasswordType()
  {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                  ),
                  child: TextFormField(
                    decoration: authInputFormatting.copyWith(hintText: "Enter Password"),
                    validator: _account.validateRegisterPass,
                    obscureText: true,
                    onChanged: (val){
                      pass = val;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                  ),
                  height: 70,
                  child: FormField<String>(
                    validator: (val) => val.isEmpty ? "Choose A Category" : null,
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: authInputFormatting.copyWith(hintText: 'Choose Account Type'),
                        isEmpty: type == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: type,
                            isDense: true,
                            onChanged: (value) {
                              setState(() {
                                type = value;
                                state.didChange(value);
                              });
                            },
                            items: _types.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text(error, style: TextStyle(color: Colors.red),),
          SizedBox(height: 30,),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentForm = _registerNameEmail();
                    });
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.cyan,
                    ),
                    child: Center(
                      child: Text("Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 17),),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async{
                    if(_formKey.currentState.validate())
                    {
                      setState(() => loading = true);
                      FirebaseUser user = await _account.register(email, pass);
                      if(user != null)
                      {
                        UserDataBase userData = UserDataBase(user) ;
                        dynamic userDataSet = await userData.newUserData(firstName, lastName, type);
                        bool isEmailVerified = user.isEmailVerified;
                        if(userDataSet != null)
                        {
                          dynamic type = await userData.userType();
                          if(type != null){
                            Navigator.of(context).pushReplacementNamed('/home', arguments: {'type' : type, 'isEmailVerified' : isEmailVerified});
                          }
                          else{
                            await _account.signOut();
                            setState(() {
                              loading = false;
                              error = 'Couldn\'t get user type, try to log in';
                            });
                          }
                        }
                        else
                        {
                          await _account.deleteUser();
                          setState(() {
                            loading = false;
                            error = "Couldn't add user details to database";
                          });
                        }
                      }
                      else
                      {
                        setState(() {
                          type = '';
                          loading = false;
                          error = "Please provide an valid E-mail";
                          _currentForm = _registerNameEmail();
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.cyan,
                    ),
                    child: Center(
                      child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 17),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
