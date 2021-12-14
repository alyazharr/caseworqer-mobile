// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:http/http.dart' as http;

// class LoginPage extends StatefulWidget {
//   static const routeName = '/login';
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _loginFormKey = GlobalKey<FormState>();
//   bool isPasswordVisible = false;
//   void togglePasswordView() {
//     setState(() {
//       isPasswordVisible = !isPasswordVisible;
//     });
//   }

//   String username = "";
//   String password1 = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Theme.of(context).primaryColor,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(30),
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 60,
//               ),
//               Image(
//                 image: AssetImage('assets/images/cover.jpg'),
//                 width: 100,
//                 height: 100,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
// // Form
//               Form(
//                 key: _loginFormKey,
//                 child: Container(
//                   child: Column(
//                     children: [
// // Username
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(250, 250, 250, 0.95),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: TextFormField(
//                           onChanged: (String value) {
//                             username = value;
//                           },
//                           decoration: InputDecoration(
//                             hintText: 'Username',
//                             hintStyle: TextStyle(
//                               color: Color.fromRGBO(200, 200, 200, 1),
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Username tidak boleh kosong";
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
// // Password
//                       Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(250, 250, 250, 0.95),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: TextFormField(
//                             onChanged: (String value) {
//                               password1 = value;
//                             },
//                             obscureText: !isPasswordVisible,
//                             decoration: InputDecoration(
//                               hintText: 'Password',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(200, 200, 200, 1),
//                               ),
//                               suffixIcon: IconButton(
//                                 color: Color.fromRGBO(200, 200, 200, 1),
//                                 splashRadius: 1,
//                                 icon: Icon(isPasswordVisible
//                                     ? Icons.visibility_outlined
//                                     : Icons.visibility_off_outlined),
//                                 onPressed: togglePasswordView,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return "Password tidak boleh kosong";
//                               }
//                               return null;
//                             },
//                           )),
//                       SizedBox(
//                         height: 30,
//                       ),
// // Login Button
//                       Container(
//                         width: double.infinity,
//                         child: TextButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color.fromRGBO(204, 23, 40, 1)),
//                             foregroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                             overlayColor:
//                                 MaterialStateProperty.resolveWith<Color?>(
//                                     (Set<MaterialState> states) {
//                               if (states.contains(MaterialState.pressed))
//                                 return Color.fromRGBO(255, 0, 0, 1);
//                               return null; // Defer to the widget's default.
//                             }),
//                           ),
//                           onPressed: () async {
//                             if (_loginFormKey.currentState!.validate()) {
//                               final response = await http.post(
//                                   Uri.parse(
//                                       "http://localhost:8000/flutter-login"),
//                                   headers: <String, String>{
//                                     'Content-Type':
//                                         'application/json; charset=UTF-8',
//                                   },
//                                   body: jsonEncode(<String, String>{
//                                     'username': username,
//                                     'password': password1,
//                                   }));
//                               print(response);
//                               print(response.body);
// // print(username);
// // print(password1);
//                             } else {
//                               print("Ga valid");
//                             }
//                           },
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               RichText(
//                 text: TextSpan(
//                     text: "Belum memiliki akun?",
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Navigator.popAndPushNamed(context, "/register");
//                       }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
