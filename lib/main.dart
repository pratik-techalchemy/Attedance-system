// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'logged_out/auth_screen.dart';

// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:final_task/classes/palette.dart';
// // import 'package:final_task/screens/splash.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:provider/provider.dart';
// // import 'package:final_task/logged_out/authentication.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   // final FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     // return MultiProvider(
//     //     providers: [
//     //       Provider<AuthenticationService>(
//     //         create: (_) => AuthenticationService(FirebaseAuth.instance),
//     //       ),
//     //       StreamProvider(
//     //         create: (context) => context.read<AuthenticationService>().authStateChanges,
//     //         initialData: null,
//     //       ),
//     //     ],
//     //     child: MaterialApp(
//     //       debugShowCheckedModeBanner: false,
//     //       title: 'Attendance System',
//     //       theme: ThemeData(
//     //         visualDensity: VisualDensity.adaptivePlatformDensity,
//     //         textTheme: GoogleFonts.muliTextTheme(),
//     //         accentColor: Palette.darkOrange,
//     //         appBarTheme: const AppBarTheme(
//     //           brightness: Brightness.dark,
//     //           color: Palette.darkBlue,
//     //         ),
//     //       ),
//     //       home: SplashScreen(),
//     //     ));
//     return MaterialApp(
//       title: 'Flutter app',
//       theme: ThemeData(
//         primaryColor: Colors.pink,
//       ),
//       home: AuthScreen(),
//     );
//   }
// }

import 'package:final_task/logged_in/student/home.dart';
import 'package:final_task/logged_in/student/requests.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:final_task/classes/account.dart';
import 'package:final_task/logged_in/home.dart';
import 'package:final_task/logged_in/teacher/add_students.dart';
import 'package:final_task/logged_in/teacher/attendance.dart';
import 'package:final_task/logged_in/teacher/batches.dart';
import 'package:final_task/logged_in/teacher/students.dart';
import 'package:final_task/logged_out/authentication.dart';
import 'package:final_task/shared/account_settings.dart';
import 'package:final_task/shared/attendance_list.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: User().account,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance App ',
        home: Authentication(),
        routes: {
          '/batches' : (context) => Batches(),
          '/enrolledStudents' : (context) => EnrolledStudents(),
          '/addStudents' : (context) => AddStudents(),
          '/addAttendance' : (context) => AddAttendance(),
          '/attendanceList' : (context) => AttendanceList(),
          '/home' : (context) => Home(),
          '/authentication': (context) => Authentication(),
          '/accountSettings': (context) => AccountSettings(),
          '/requests': (context) => Requests(),
          '/studentHome': (context) => StudentHome(),
        },
      ),
    );
  }
}
